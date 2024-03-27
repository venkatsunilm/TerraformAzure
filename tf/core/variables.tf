variable "location" {
  description = "Azure location to use for deploying resources."
  type        = string
  default     = "westeurope"
}

# variable "environment" {
#   description = "The deployment environment (e.g., dev, staging, production)."
#   type        = string
#   validation {
#     condition     = regex("^dev$|^staging$|^production$")
#     error_message = "Valid values are 'dev', 'staging', or 'production'."
#   }
# }

variable "environment" {
  description = "The deployment environment (e.g., dev, staging, production)."
  type        = string

  validation {
    condition     = can(regex("^dev$|^staging$|^production$", var.environment))
    error_message = "Invalid environment specified. Please use 'dev', 'staging', or 'production'."
  }
}

