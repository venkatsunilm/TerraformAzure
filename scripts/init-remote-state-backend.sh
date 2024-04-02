#!/bin/bash

set -e

. ./init-env-vars.sh  # Load environment variables

echo "Using resource group: $COMMON_RESOURCE_GROUP_NAME"
echo "Using key vault name: $KEYVAULT_NAME"
echo "$(az group exists --resource-group "$COMMON_RESOURCE_GROUP_NAME")"

# Create the resource group (if needed)
az group create -n "$COMMON_RESOURCE_GROUP_NAME" -l "$LOCATION"
if (az group exists --resource-group "$COMMON_RESOURCE_GROUP_NAME"); then
  echo "Resource group $COMMON_RESOURCE_GROUP_NAME exists..."
else
  echo "Creating $COMMON_RESOURCE_GROUP_NAME resource group..."
  az group create -n "$COMMON_RESOURCE_GROUP_NAME" -l "$LOCATION"
  echo "Resource group $COMMON_RESOURCE_GROUP_NAME created."
fi

# Create the storage account (if needed)
if (az storage account check-name --name "$TF_STATE_STORAGE_ACCOUNT_NAME" --query 'nameAvailable'); then  # Check for non-availability
  echo "Creating $TF_STATE_STORAGE_ACCOUNT_NAME storage account..."
  az storage account create -g "$COMMON_RESOURCE_GROUP_NAME" -l "$LOCATION" \
    --name "$TF_STATE_STORAGE_ACCOUNT_NAME" \
    --sku Standard_LRS \
    --encryption-services blob
  echo "Storage account $TF_STATE_STORAGE_ACCOUNT_NAME created."
else
  echo "Storage account $TF_STATE_STORAGE_ACCOUNT_NAME exists..."
fi

# Retrieve the storage account key
echo "Retrieving storage account key..."
ACCOUNT_KEY=$(az storage account keys list --resource-group "$COMMON_RESOURCE_GROUP_NAME" --account-name "$TF_STATE_STORAGE_ACCOUNT_NAME" --query [0].value -o tsv)
echo "Storage account key retrieved. $ACCOUNT_KEY"

storage_container_exists=$(az storage container exists --name "$TF_STATE_CONTAINER_NAME" --account-name "$TF_STATE_STORAGE_ACCOUNT_NAME" --account-key "$ACCOUNT_KEY" --query exists)
echo "storage container '$TF_STATE_CONTAINER_NAME' exists: $storage_container_exists"

# Create a storage container (if needed)
if [[ -z "$storage_container_exists" ]]; then
  echo "Storage container $TF_STATE_CONTAINER_NAME exists..."
else
  echo "Creating $TF_STATE_CONTAINER_NAME storage container..."
  az storage container create --name "$TF_STATE_CONTAINER_NAME" --account-name "$TF_STATE_STORAGE_ACCOUNT_NAME" --account-key "$ACCOUNT_KEY"
  echo "Storage container $TF_STATE_CONTAINER_NAME created."
fi

# read -p "Press Enter to continue..."

# Check if Key Vault exists
keyvault_exists=$(az keyvault list --query "[?name == '$KEYVAULT_NAME'].name | [0]")
echo "Key Vault '$KEYVAULT_NAME' exists: $keyvault_exists"

if [[ -z "$keyvault_exists" ]]; then
  # Create Key Vault if it doesn't exist
  echo "Creating $KEYVAULT_NAME key vault..."
  az keyvault create -g "$COMMON_RESOURCE_GROUP_NAME" -l "$LOCATION" --name "$KEYVAULT_NAME"
  echo "Key vault $KEYVAULT_NAME created."
else
  echo "Key Vault $KEYVAULT_NAME already exists."
fi

# Store the Terraform State Storage Key into KeyVault
echo "Store storage access key into key vault secret..."
az keyvault secret set --name tfstate-storage-key --value "$ACCOUNT_KEY" --vault-name "$KEYVAULT_NAME" -o none

echo "Key vault secret created."

# read -p "Press Enter to continue..."

# Display information
echo "Azure Storage Account and KeyVault have been created."
echo "Run the following command to initialize Terraform to store its state into Azure Storage:"
echo "terraform init -backend-config=\"storage_account_name=$TF_STATE_STORAGE_ACCOUNT_NAME\" -backend-config=\"container_name=$TF_STATE_CONTAINER_NAME\" -backend-config=\"access_key=\$(az keyvault secret show --name tfstate-storage-key --vault-name $KEYVAULT_NAME --query value -o tsv)\" -backend-config=\"key=terraform-architecture-tfstate\""
