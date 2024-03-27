variable "location" {
  description = "Azure location to use for deploying resources."
  type        = string
  default     = "westeurope"
}

variable "environment" {
  description = "The deployment environment (e.g., dev, staging, production)."
  type        = string

  validation {
    condition     = can(regex("^dev$|^staging$|^production$", var.environment))
    error_message = "Invalid environment specified. Please use 'dev', 'staging', or 'production'."
  }
}

