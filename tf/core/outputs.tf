/*
This Terraform code defines the outputs for the Azure resource group, location, and environment.

- The "resource_group_name" output retrieves the name of the Azure resource 
    group created using the "azurerm_resource_group" resource.
- The "location" output retrieves the value of the "location" variable, 
    which specifies the Azure region where the resources will be deployed.
- The "environment" output retrieves the value of the "environment" variable, 
    which specifies the environment (e.g., dev, staging, production) for the resources.

These outputs can be used to reference the created resource group name, location, 
and environment in other parts of the Terraform code or for external use.

*/


output "resource_group_name" {
  value = azurerm_resource_group.rg.name
}

output "location" {
  value = var.location
}

output "environment" {
  value = var.environment
}
