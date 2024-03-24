variable "location" {
  description = "Azure location to use"
}

variable "common_resource_group_name" {
  type        = string
  description = "common resource group name"
}

variable "state_storage_account_name" {
  type        = string
  description = "tf state storage account name"
}

variable "state_storage_container_name" {
  type        = string
  description = "tf state storage container name"
}

variable "keyvault_name" {
  type        = string
  description = "common resource group name"
}
