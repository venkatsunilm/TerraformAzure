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
  # skip_provider_registration = true # This is only required when the User, Service Principal, or Identity running Terraform lacks the permissions to register Azure Resource Providers.
  features {}
}

# module "common" {
#   source    = "git::ssh://git@github.com/venkatsunilm/terraform-azure-ref-common-module.git"
#   location  = var.location
#   tenant_id = var.tenant_id
# }

