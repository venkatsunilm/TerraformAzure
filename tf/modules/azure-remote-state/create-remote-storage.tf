terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.0"
    }
  }

  backend "azurerm" {}
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
  name     = var.common_resource_group_name
  location = var.location
}

resource "azurerm_storage_account" "tfstate" {
  name                            = "${var.state_storage_account_name}${random_string.resource_code.result}"
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
  name                  = var.state_storage_container_name
  storage_account_name  = azurerm_storage_account.tfstate.name
  container_access_type = "private"

  # provisioner "local-exec" {
  #   command = "bash ./scripts/init-remote-state.sh" # ../../scripts/init-env-vars.shReplace with the actual path to your script
  #   when    = create                                # Run the script after the container is created
  # }
}
