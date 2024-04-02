/**
 * Module Variables
 *
 * This file defines the variables used in the AKS module.
 */

variable "environment" {
  description = "Name of the environment"
  type        = string
  default     = "dev"
}

variable "location" {
  description = "Azure location to use"
  type        = string
  default     = "westeurope"
}

variable "kubernetes_version" {
  description = "The Kubernetes version to use"
  type        = string
  default     = "1.29.3"
}

variable "service_principal_client_id" {
  description = "The client ID of the service principal to be used by AKS"
  type        = string
  default     = ""
  sensitive   = true
}

variable "service_principal_client_secret" {
  description = "The client secret of the service principal to be used by AKS"
  type        = string
  default     = ""
  sensitive   = true
}

variable "ssh_public_key" {
  description = "The SSH public key to use with AKS"
  type        = string
  default     = ""
  sensitive   = true
}
