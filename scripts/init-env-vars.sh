#!/bin/bash

set -e

export LOCATION=westeurope
export COMMON_RESOURCE_GROUP_NAME=terraform-rg
export TF_STATE_STORAGE_ACCOUNT_NAME=tfstate2195
export TF_STATE_CONTAINER_NAME=tfstate
export KEYVAULT_NAME=terraform-kv

export TF_VAR_location=westeurope
export TF_VAR_common_resource_group=terraform-rg
export TF_VAR_storage_account=tfstate
export TF_VAR_container=tfstate