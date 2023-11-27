variable "resource_group_name" {
  description = "Name of the Azure Resource Group"
  default     = "myrg"
}
 
variable "location" {
  description = "Azure region"
  default     = "East US"
}
 
variable "vm_name" {
  description = "Name of the VM"
  default     = "myvm"
}
 
variable "image_gallery_name" {
  description = "Name of the Shared Image Gallery"
  default     = "myimages"
}
 
variable "image_definition_name" {
  description = "Name of the Image Definition in the Gallery"
  default     = "windows-allowed-prod"
}
 
variable "image_version" {
  description = "Version of the image in the Gallery"
  default     = "0.0.1"
}
 
variable "admin_username" {
  description = "Admin username for the VM"
  default     = "ramesh"
}
 
variable "admin_password" {
  description = "Admin password for the VM"
  default     = "R@meshBoya123"
}
