terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.0"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "random_string" "resource_code" {
  length  = 5
  special = false
  upper   = false
}

resource "azurerm_resource_group" "tfstate" {
  name     = var.common_resource_group
  location = var.location
}

resource "azurerm_storage_account" "tfstate" {
  name                            = "${var.storage_account}${random_string.resource_code.result}"
  resource_group_name             = azurerm_resource_group.tfstate.name
  location                        = azurerm_resource_group.tfstate.location
  account_tier                    = "Standard"
  account_replication_type        = "LRS"
  allow_nested_items_to_be_public = false

  tags = {
    environment = "dev"
  }
}

resource "azurerm_storage_container" "tfstate" {
  name                  = var.container
  storage_account_name  = azurerm_storage_account.tfstate.name
  container_access_type = "private"
}

# export KEYVAULT_NAME=terraform-kv
# name                            = "tfstate${random_string.resource_code.result}"
