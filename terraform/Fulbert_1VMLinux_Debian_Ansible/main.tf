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

#Création de l'image
resource "nutanix_image" "image" {
  name        = var.image_name
  description = var.image_name
  source_uri  = var.image_url
}


#Template cloud-init en lui transmettant les variables necessaires
data "template_file" "userdata" {
    template = file("${path.module}/cloud-init/custom-debian.tpl")
    vars = {
        vm_user = var.vm_user
        vm_name = var.vm_name
        vm_password = var.vm_password
        vm_public_key = var.vm_public_key
        vm_domain = var.vm_domain
    }
}

#definition de la VM
resource "nutanix_virtual_machine" "vm1" {
  name                 = var.vm_name
  description          = var.vm_name 
  cluster_uuid         = data.nutanix_cluster.cluster.id
  num_vcpus_per_socket = "2"
  num_sockets          = "1"
  memory_size_mib      = 1024

  #configuration du disque corresponda à l'image
  disk_list {
    data_source_reference = {
      kind = "image"
      uuid = nutanix_image.image.id
    }
  }

  #configuration du reseau
  nic_list {
    subnet_uuid = data.nutanix_subnet.subnet.id
    ip_endpoint_list {
      ip = "172.16.99.150"
      type = "ASSIGNED"
    } 
  }

  #provisionnement de la VM a partir d'un template cloud-init
  guest_customization_cloud_init_user_data = base64encode(data.template_file.userdata.rendered)
}
