#!/bin/bash

# This script initializes the Terraform backend configuration for the common module.

set -e

# Source the environment variables from the init-env-vars.sh script.
. ../../scripts/init-env-vars.sh

# Print the Terraform init command with backend configuration.
echo "terraform init -backend-config=\"storage_account_name=$TF_STATE_STORAGE_ACCOUNT_NAME\" \
    -backend-config=\"container_name=$TF_STATE_CONTAINER_NAME\" \
    -backend-config=\"access_key=\$(az keyvault secret show --name tfstate-storage-key --vault-name $KEYVAULT_NAME --query value -o tsv)\" \
    -backend-config=\"key=common.tfstate\""

# Run the Terraform init command with backend configuration.
terraform init -backend-config="storage_account_name=$TF_STATE_STORAGE_ACCOUNT_NAME" \
    -backend-config="container_name=$TF_STATE_CONTAINER_NAME" \
    -backend-config="access_key=$(az keyvault secret show --name tfstate-storage-key --vault-name $KEYVAULT_NAME --query value -o tsv)" \
    -backend-config="key=common.tfstate"