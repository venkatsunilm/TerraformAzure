/**
 * Module Variables
 *
 * This file contains the variable declarations for the Terraform Azure deployment. 
 * It defines the variables used to configure the deployment of resources.
 */

variable "location" {
  description = "Azure location to use for deploying resources."
  type        = string
  default     = "westeurope"
}

variable "environment" {
  description = "The deployment environment (e.g., dev, staging, production)."
  type        = string
  default     = "dev"

  validation {
    condition     = can(regex("^dev$|^staging$|^production$", var.environment))
    error_message = "Invalid environment specified. Please use 'dev', 'staging', or 'production'."
  }
}
