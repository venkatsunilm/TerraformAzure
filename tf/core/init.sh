#!/bin/bash

# This script initializes the Terraform backend configuration and sets up the environment for Terraform operations.

set -e

# Get the environment name as a command-line argument
ENVIRONMENT_NAME=$1

# Source the script to initialize environment variables
. ../../scripts/init-env-vars.sh

ACCESS_KEY=$(az keyvault secret show --name tfstate-storage-key --vault-name $KEYVAULT_NAME --query value -o tsv)

# Print the Terraform init command with backend configuration
echo "terraform init -backend-config=\"storage_account_name=$TF_STATE_STORAGE_ACCOUNT_NAME\" \
    -backend-config=\"container_name=$TF_STATE_CONTAINER_NAME\" \
    -backend-config=\"access_key=$ACCESS_KEY\" \
    -backend-config=\"key=$ENVIRONMENT_NAME.core.tfstate\""

# echo $(az keyvault secret show --name tfstate-storage-key --vault-name $KEYVAULT_NAME --query value -o tsv)


# Initialize Terraform with backend configuration
terraform init -backend-config="storage_account_name=$TF_STATE_STORAGE_ACCOUNT_NAME" \
    -backend-config="container_name=$TF_STATE_CONTAINER_NAME" \
    -backend-config="access_key=$ACCESS_KEY" \
    -backend-config="key=$ENVIRONMENT_NAME.core.tfstate"

# Uncomment the following line if you want to migrate the state to the new backend
# terraform init -migrate-state -backend-config="storage_account_name=$TF_STATE_STORAGE_ACCOUNT_NAME" \
#     -backend-config="container_name=$TF_STATE_CONTAINER_NAME" \
#     -backend-config="access_key=$(az keyvault secret show --name tfstate-storage-key --vault-name $KEYVAULT_NAME --query value -o tsv)" \
#     -backend-config="key=$ENVIRONMENT_NAME.core.tfstate"