variable "cluster_name" {
  type = string
}
variable "subnet_name" {
  type = string
}
variable "password" {
  type = string
}
variable "endpoint" {
  type = string
}
variable "user" {
  type = string
}

#Image variables
variable "image_name" {
  type = string
}

variable "image_url" {
  type = string
}

# Custom variables
variable "vm_name" {
  type = string
}

variable "vm_domain" {
  type = string
}

variable "vm_user" {
  type = string
}

variable "vm_public_key" {
  type = string
}

variable "vm_password" {
  type = string
}
