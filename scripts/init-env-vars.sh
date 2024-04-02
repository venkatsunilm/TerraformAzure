#!/bin/bash

set -e

export TF_VAR_environment="dev"
export TF_VAR_location="westeurope"
export TF_VAR_common_resource_group_name="terraform-ref-rg"
export TF_VAR_state_storage_account_name="tfstatef5mri"
export TF_VAR_state_storage_container_name="tfstate-ref"
export TF_VAR_keyvault_name="tf-ref-kv-f5mri-1"

export LOCATION=$TF_VAR_location
export COMMON_RESOURCE_GROUP_NAME=$TF_VAR_common_resource_group_name
export TF_STATE_STORAGE_ACCOUNT_NAME=$TF_VAR_state_storage_account_name
export TF_STATE_CONTAINER_NAME=$TF_VAR_state_storage_container_name
export KEYVAULT_NAME=$TF_VAR_keyvault_name

echo "TF_STATE_CONTAINER_NAME is: $TF_STATE_CONTAINER_NAME"
