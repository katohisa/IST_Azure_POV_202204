terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "2.95.0"
    }
  }
}

provider "azurerm" {
  features {}
  # Configuration options
}

data "azurerm_snapshot" "azsnap" {
  name                = var.snap_name
  resource_group_name = var.rg_name
}


resource "azurerm_managed_disk" "manageddisk" {
  name                = var.managed_disk
  location            = var.location
  resource_group_name = var.rg_name
  # Disk type:
  # Standard_LRS = HDD Standard
  # StandardSSD_LRS = SSD Standard
  # Premium_LRS = SSD Premium
  storage_account_type = "StandardSSD_LRS"
  # option, copy and create a new disk from snapshot
  create_option = "Copy"
  # Snapshot ID
  source_resource_id = data.azurerm_snapshot.azsnap.id
  disk_size_gb       = "127"
}


resource "azurerm_virtual_network" "main" {
  name                = "${var.prefix}-network"
  address_space       = ["10.0.0.0/16"]
  location            = var.location
  resource_group_name = var.rg_name
}

resource "azurerm_subnet" "internal" {
  name                 = "internal"
  resource_group_name  = var.rg_name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_network_interface" "main" {
  name                = "${var.prefix}-nic"
  location            = var.location
  resource_group_name = var.rg_name

  ip_configuration {
    name                          = "testconfiguration1"
    subnet_id                     = azurerm_subnet.internal.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.myterraformpublicip.id

  }
}

# Create public IPs
resource "azurerm_public_ip" "myterraformpublicip" {
  name                = "myPublicIP"
  location            = var.location
  resource_group_name = var.rg_name
  allocation_method   = "Dynamic"

  tags = {
    environment = "Terraform Demo"
  }
}

# Connect the security group to the network interface
resource "azurerm_network_interface_security_group_association" "example" {
  network_interface_id      = azurerm_network_interface.main.id
  network_security_group_id = azurerm_network_security_group.myterraformnsg.id
}



resource "azurerm_network_security_group" "myterraformnsg" {
  name                = "myNetworkSecurityGroup"
  location            = var.location
  resource_group_name = var.rg_name

  security_rule {
    name                       = "RDP"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
  tags = {
    environment = "staging"
  }
}


resource "azurerm_virtual_machine" "main" {
  name                  = "${var.prefix}-vm"
  location              = var.location
  resource_group_name   = var.rg_name
  network_interface_ids = [azurerm_network_interface.main.id]
  vm_size               = "Standard_DS1_v2"

  # Uncomment this line to delete the OS disk automatically when deleting the VM
  # delete_os_disk_on_termination = true

  # Uncomment this line to delete the data disks automatically when deleting the VM
  # delete_data_disks_on_termination = true


  storage_os_disk {
    name              = "${azurerm_managed_disk.manageddisk.name}"
    caching           = "ReadWrite"
    os_type           = "Windows"
    disk_size_gb      = "128"
    managed_disk_id = "${azurerm_managed_disk.manageddisk.id}"
    create_option     = "Attach"
    managed_disk_type = "Standard_LRS"
  }

  #   os_profile_linux_config {
  #     disable_password_authentication = false
  #   }
  tags = {
    environment = "staging"
  }
}