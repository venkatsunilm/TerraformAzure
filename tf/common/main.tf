/*
  This Terraform configuration file sets up the common infrastructure 
  resources in Azure using the Azure Resource Manager (ARM) provider.

  It includes the following sections:

  1. Terraform Block:
     - Specifies the required provider and backend configurations.
     - Uses the "azurerm" provider from HashiCorp with version 3.97.1.

  2. Provider Block:
     - Configures the "azurerm" provider.
     - Enables all available features.

  3. Module Block:
     - Deploys the "common" module from the GitHub repository 
     "terraform-azure-ref-common-module".
     - Passes the values of "location" and "tenant_id" variables to the module.

  Note: Before running this Terraform configuration, make sure you have the 
  necessary permissions to register Azure Resource Providers.

  Read more in Readme.rd file.
*/

terraform {

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.97.1"
    }
  }

  backend "azurerm" {}
}

provider "azurerm" {
  # skip_provider_registration = true # This is only required when the User, Service Principal, or Identity running Terraform lacks the permissions to register Azure Resource Providers.
  features {}
}

module "common" {
  source    = "git::ssh://git@github.com/venkatsunilm/terraform-azure-ref-common-module.git"
  location  = var.location
  tenant_id = var.tenant_id
}

