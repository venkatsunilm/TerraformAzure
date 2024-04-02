/*
  This Terraform configuration file is used to create an Azure Kubernetes Service (AKS) 
  using a module. It configures the required providers and backend for Terraform, 
  and specifies the input variables for the module.

  Terraform Version: The configuration requires Terraform version 0.13 or later.

  Required Providers:
  - azurerm: This provider is used to interact with Azure resources. The version used is 3.97.1.

  Backend Configuration:
  - azurerm: The backend is configured to store the Terraform state in Azure.

  Module Configuration:
  - aks: This module is sourced from the GitHub repository "venkatsunilm/terraform-azure-ref-aks-module".
    It creates an Azure Kubernetes Service (AKS) with the specified input variables.

  Input Variables:
  - environment: The environment in which the AKS will be deployed.
  - location: The Azure region where the AKS will be created.
  - kubernetes_version: The version of Kubernetes to use for the AKS.
  - service_principal_client_id: The client ID of the service principal used for authentication.
  - service_principal_client_secret: The client secret of the service principal used for authentication.
  - ssh_public_key: The public key used for SSH access to the AKS nodes.

  Read more in Readme.rd file.
*/

# Configure the Terraform version and required providers
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.97.1"
    }
  }

  # Configure the backend to store Terraform state in Azure
  backend "azurerm" {}
}

# Create an Azure Kubernetes Service (AKS) using a module
module "aks" {
  # Specify the source of the module
  source = "git@github.com:venkatsunilm/terraform-azure-ref-aks-module.git"

  # Define input variables for the module
  environment                     = var.environment
  location                        = var.location
  kubernetes_version              = var.kubernetes_version
  service_principal_client_id     = var.service_principal_client_id
  service_principal_client_secret = var.service_principal_client_secret
  ssh_public_key                  = var.ssh_public_key
}
