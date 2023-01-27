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

#define nombre de VM
variable "vm_count" {
  type = number
}

#Image variables

variable "image_blocnames" {
   type = list
}

variable "image_names" {
   type = list
}

variable "image_descriptions" {
   type = list
}

variable "image_urls" {
   type = list
}

# Custom variables
variable "vm_names" {
  type = list
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