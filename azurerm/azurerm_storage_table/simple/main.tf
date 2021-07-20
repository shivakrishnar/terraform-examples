# Summary: A simple Azure Storage Table

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
resource "azurerm_resource_group" "changeme_simple_storage_table_resource_group" {
  name     = "changeme-simple-storage-table-resource-group"
  location = "West Europe"
}

# Storage Account within the Resource Group
# Documentation: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account
resource "azurerm_storage_account" "changeme_simple_storage_table_storage_account" {
  name                     = "changemesimpletsaname"
  resource_group_name      = azurerm_resource_group.changeme_simple_storage_table_resource_group.name
  location                 = azurerm_resource_group.changeme_simple_storage_table_resource_group.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

# Storage Table in the Storage Account
# Documentation: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_table
resource "azurerm_storage_table" "changeme_simple_storage_table" {
  name                 = "changemesimpletablename"
  storage_account_name = azurerm_storage_account.changeme_simple_storage_table_storage_account.name
}