# Resource Group
resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}
 
# Virtual Network
resource "azurerm_virtual_network" "vnet" {
  name                = "your-vnet"
resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
address_space = ["10.0.0.0/16"]
}
 
# Subnet
resource "azurerm_subnet" "subnet" {
  name                 = "your-subnet"
resource_group_name = azurerm_resource_group.rg.name
virtual_network_name = azurerm_virtual_network.vnet.name
address_prefixes = ["10.0.1.0/24"]
}
 
# Public IP
resource "azurerm_public_ip" "public_ip" {
  name                = "your-public-ip"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Dynamic"
}
 
# Network Interface
resource "azurerm_network_interface" "nic" {
  name                = "your-nic"
resource_group_name = azurerm_resource_group.rg.name
 location            = azurerm_resource_group.rg.location
  ip_configuration {
    name                          = "internal"
subnet_id = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
public_ip_address_id = azurerm_public_ip.public_ip.id
  }
}
 
# Virtual Machine
resource "azurerm_virtual_machine" "vm" {
  name                  = var.vm_name
resource_group_name = azurerm_resource_group.rg.name
  location              = azurerm_resource_group.rg.location
  vm_size               = "Standard_DS2_v2"
network_interface_ids = [azurerm_network_interface.nic.id]
 
 storage_os_disk {
        name              = "TFOsDisk"
        caching           = "ReadWrite"
        create_option     = "FromImage"
        managed_disk_type = "Premium_LRS"
    }
 
  storage_image_reference {
    publisher = "MicrosoftWindowsDesktop"
    offer     = "Windows-10"
    sku       = "win10-22h2-pro-g2"
    version   = var.image_version
  }
 
  os_profile {
    computer_name  = var.vm_name
    admin_username = var.admin_username
    admin_password = var.admin_password
  }
 
  os_profile_linux_config {
    disable_password_authentication = false
  }
}
