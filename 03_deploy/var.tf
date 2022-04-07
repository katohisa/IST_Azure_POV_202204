# target resource group
variable "rg_name" {
  default = "prod"
  type    = string
}

# Image Resource Group
variable "src_rg_name" {
  default = "winrg"
  type    = string
}

# location
variable "location" {
  default = "westus"
  type    = string
}

# image name
variable "image_name" {
  default = "stagevm-image-20220407205207"
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
