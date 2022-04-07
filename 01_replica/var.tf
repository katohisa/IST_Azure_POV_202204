# target resource group
variable "rg_name" {
  default = "win-origin"
  type    = string
}
# target managed disk name
variable "managed_disk" {
  default = "stg-disk"
}
# location
variable "location" {
  default = "westus"
  type    = string
}
variable "prefix" {
  default = "web"
}

variable "snap_name" {
  default = "win2019-ja-vscode"
  type    = string
}

# image name
variable "image_name" {
  default = "stagevm-image-20220407205207"
  type    = string
}
