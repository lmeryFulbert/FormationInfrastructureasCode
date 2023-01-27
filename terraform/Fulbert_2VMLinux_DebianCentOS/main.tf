terraform {
  required_providers {
    nutanix = {
      source  = "nutanix/nutanix"
      version = "1.2.0"
    }
  }
}

#Cluster sur lequel on travaille
data "nutanix_cluster" "cluster" {
  name = var.cluster_name
}

# vlan auquel sera attaché la VM
# doit avoir été créé au préalable dans nutanix
# nom du vlan dans le fichier des variables
data "nutanix_subnet" "subnet" {
  subnet_name = var.subnet_name
}

#Credentials pour se connecter à nutanix (basé sur le fichier de variable)
provider "nutanix" {
  username     = var.user
  password     = var.password
  endpoint     = var.endpoint
  insecure     = true
  wait_timeout = 60
}

#Création de l'image 1 (debian)     
#attention a bien nommer la ressource avec le nom defini dans les valeur contenu  dans le tableau de variables image_blocnames
resource "nutanix_image" "imagedebian" {
  name        = var.image_names[0]
  description = var.image_descriptions[0]
  source_uri  = var.image_urls[0]
}

#Création de l'image 2 (centos)
resource "nutanix_image" "imagecentos" {
  name        = var.image_names[1]
  description = var.image_descriptions[1]
  source_uri  = var.image_urls[1]
}


#Template cloud-init en lui transmettant les variables necessaires
data "template_file" "cloud" {
    count = var.vm_count
    template = file("${path.module}/cloud-init/custom.tpl")
    vars = {
        vm_user = var.vm_user
        vm_name =  "${var.vm_names[count.index]}"
        vm_domain = var.vm_domain
        vm_password = var.vm_password
        vm_public_key = var.vm_public_key
    }
}

#definition des VMs
resource "nutanix_virtual_machine" "vms" {
  count                = var.vm_count
  name                 = var.vm_names[count.index]
  description          = var.vm_names[count.index]
  cluster_uuid         = data.nutanix_cluster.cluster.id
  num_vcpus_per_socket = "2"
  num_sockets          = "1"
  memory_size_mib      = 1024

  #configuration du disque corresponda à l'image
  disk_list {
    data_source_reference = {
      kind = "image"

      #utilisation d'un if avec une syntaxe un peu particuliere  ? true : false
      uuid = count.index == 0 ? nutanix_image.imagedebian.id  : nutanix_image.imagecentos.id

      #ne fonctionne pas car on n'attend pas une chaine de caracteres mais un id.
      #uuid = "nutanix_image.${var.image_blocnames[count.index]}.id"   #utilisation de l'image correspondant à l'indice de l'image
    }
  }

  #configuration du reseau (DHCP)
  nic_list {
    subnet_uuid = data.nutanix_subnet.subnet.id
    ip_endpoint_list {
      ip = "172.16.99.0"
      type = "LEARNED"
    } 
  }

  #provisionnement de la VM a partir d'un template cloud-init
  guest_customization_cloud_init_user_data = base64encode(data.template_file.cloud[count.index].rendered)
}