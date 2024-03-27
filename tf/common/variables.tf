variable "location" {
  description = "Azure location to use for deploying resources."
  type        = string
  default     = "westeurope"
}

variable "tenant_id" {
  description = "The ID of the Azure tenant where resources will be deployed."
  type        = string
  sensitive   = true
}
