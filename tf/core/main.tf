/*
  This Terraform configuration file defines the infrastructure 
  resources required for the core module. It provisions an Azure resource group, 
  virtual networks, and subnets.

  Terraform Version: 0.15.0

  Required Providers:
    - azurerm (hashicorp/azurerm)

  Backend Configuration:
    - Azure Storage Account

  Resource Details:
    - azurerm_resource_group: Creates an Azure resource group.
    - azurerm_virtual_network: Creates an Azure virtual network.
    - azurerm_subnet: Creates an Azure subnet.
    - azurerm_virtual_network_peering: Creates a virtual network 
    peering between two Azure virtual networks.

  Usage:
  Please refer to the Readme.md file for detailed information on the module.

  Note: Make sure to authenticate with Azure using the appropriate 
  credentials before running Terraform commands.

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
  # skip_provider_registration = true # This is only required when the User, Service Principal, 
  # or Identity running Terraform lacks the permissions to register Azure Resource Providers.
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = "tf-ref-${var.environment}-rg"
  location = var.location
}

resource "azurerm_virtual_network" "aks" {
  name                = "aks-vnet"
  address_space       = ["10.1.0.0/16"]
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_subnet" "aks" {
  name                 = "aks-subnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.aks.name
  address_prefixes     = ["10.1.1.0/24"]
}

resource "azurerm_virtual_network" "backend" {
  name                = "backend-vnet"
  address_space       = ["10.2.0.0/16"]
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_subnet" "backend" {
  name                 = "backend-subnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.backend.name
  address_prefixes     = ["10.2.1.0/24"]
}

resource "azurerm_virtual_network_peering" "peering1" {
  name                      = "aks2backend"
  resource_group_name       = azurerm_resource_group.rg.name
  virtual_network_name      = azurerm_virtual_network.aks.name
  remote_virtual_network_id = azurerm_virtual_network.backend.id
}

resource "azurerm_virtual_network_peering" "peering2" {
  name                      = "backend2aks"
  resource_group_name       = azurerm_resource_group.rg.name
  virtual_network_name      = azurerm_virtual_network.backend.name
  remote_virtual_network_id = azurerm_virtual_network.aks.id
}
