/**
 * Outputs for Common Module
 *
 * This Terraform file defines the outputs for the Common module.
 * These outputs provide information about the created resource group.

 These outputs can be used to reference the created resource group name
 in other parts of the Terraform code or for external use.

 */
output "resource_group_name" {
  value       = module.common.resource_group_name
  description = "The name of the resource group."
}
