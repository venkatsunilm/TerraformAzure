#!/bin/bash

# This script initializes the Terraform backend configuration for managing Azure Kubernetes Service (AKS) resources.
# It sets up the backend configuration using the provided environment name and retrieves the necessary values from Azure Key Vault.

set -e

# The environment name is passed as the first argument to the script.
ENVIRONMENT_NAME=$1

# Source the script that initializes the environment variables.
. ../../scripts/init-env-vars.sh

# Print the Terraform init command with the backend configuration values.
echo "terraform init -backend-config=\"storage_account_name=$TF_STATE_STORAGE_ACCOUNT_NAME\" \
    -backend-config=\"container_name=$TF_STATE_CONTAINER_NAME\" \
    -backend-config=\"access_key=\$(az keyvault secret show --name tfstate-storage-key --vault-name $KEYVAULT_NAME --query value -o tsv)\" \
    -backend-config=\"key=$ENVIRONMENT_NAME.aks.tfstate\""

# Run the Terraform init command with the backend configuration values.
terraform init -backend-config="storage_account_name=$TF_STATE_STORAGE_ACCOUNT_NAME" \
    -backend-config="container_name=$TF_STATE_CONTAINER_NAME" \
    -backend-config="access_key=$(az keyvault secret show --name tfstate-storage-key --vault-name $KEYVAULT_NAME --query value -o tsv)" \
    -backend-config="key=$ENVIRONMENT_NAME.aks.tfstate"