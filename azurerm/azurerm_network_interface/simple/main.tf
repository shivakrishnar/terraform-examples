# Summary: A simple Azure Linux Virtual Machine

# Documentation: https://www.terraform.io/docs/language/settings/index.html
terraform {
  required_version = ">= 0.14.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 2.0"
    }
  }
}

# Documentation: https://www.terraform.io/docs/language/values/variables.html
variable "azure_subscription_id" {
  type = string
}

# Documentation: https://www.terraform.io/docs/language/providers/requirements.html
# Documentation: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs
provider "azurerm" {
  features {}

  subscription_id = var.azure_subscription_id
}

# Resource Group
# Documentation: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group
resource "azurerm_resource_group" "changeme_simple_network_interface_resource_group" {
  name     = "changeme-simple-network-interface-resource-group-name"
  location = "West Europe"
}

# Virtual Network within the Resource Group
# Documentation: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network
resource "azurerm_virtual_network" "changeme_simple_network_interface_virtual_network" {
  name                = "changeme-simple-network-interface-virtual-network-name"
  resource_group_name = azurerm_resource_group.changeme_simple_network_interface_resource_group.name
  location            = azurerm_resource_group.changeme_simple_network_interface_resource_group.location
  address_space       = ["10.0.0.0/16"]
}

# Subnet within the Virtual Network
# Documentation: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet
resource "azurerm_subnet" "changeme_simple_network_interface_subnet" {
  name                 = "changeme-simple-network-interface-subnet-name"
  resource_group_name  = azurerm_resource_group.changeme_simple_network_interface_resource_group.name
  virtual_network_name = azurerm_virtual_network.changeme_simple_network_interface_virtual_network.name
  address_prefixes     = ["10.0.1.0/24"]
}

# NIC attached to the Subnet
# Documentation: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface
resource "azurerm_network_interface" "changeme_simple_network_interface" {
  name                = "changeme-simple-network-interface-name"
  location            = azurerm_resource_group.changeme_simple_network_interface_resource_group.location
  resource_group_name = azurerm_resource_group.changeme_simple_network_interface_resource_group.name

  ip_configuration {
    name                          = "changeme-ipconfig-name"
    subnet_id                     = azurerm_subnet.changeme_simple_network_interface_subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}
