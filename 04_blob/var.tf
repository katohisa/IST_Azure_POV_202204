# target resource group
variable "rg_name" {
  default = "prod-2"
  type    = string
}

# Image Resource Group
variable "src_rg_name" {
  default = "stg"
  type    = string
}
# prefix
variable "prefix" {
  default = "prod"
}

# location
variable "location" {
  default = "westus"
  type    = string
}

# image name
variable "image_name" {
  default = "prodvm-image"
  type    = string
}

# windows administrator user
variable "admin_user" {
  default = "azureuser"
  type    = string
}
# windows administrator password
variable "admin_password" {
  default = "Password1234"
  type    = string
}
# computer hostname
variable "computer_name" {
  default = "win2019"
  type    = string
}
