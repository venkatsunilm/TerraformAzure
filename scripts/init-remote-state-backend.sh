#!/bin/bash

set -e

. ./init-env-vars.sh

# Create the resource group
if  ( `az group exists --resource-group $COMMON_RESOURCE_GROUP_NAME` == "true" );
then
    echo "Resource group $COMMON_RESOURCE_GROUP_NAME exists..."
else
    echo "Creating $COMMON_RESOURCE_GROUP_NAME resource group..."
    az group create -n $COMMON_RESOURCE_GROUP_NAME -l $LOCATION
    echo "Resource group $COMMON_RESOURCE_GROUP_NAME created."
fi

# Create the storage account
if ( `az storage account check-name --name $TF_STATE_STORAGE_ACCOUNT_NAME --query 'nameAvailable'` == "true" );
then
    echo "Creating $TF_STATE_STORAGE_ACCOUNT_NAME storage account..."
    az storage account create -g $COMMON_RESOURCE_GROUP_NAME -l $LOCATION \
    --name $TF_STATE_STORAGE_ACCOUNT_NAME \
    --sku Standard_LRS \
    --encryption-services blob
    echo "Storage account $TF_STATE_STORAGE_ACCOUNT_NAME created."
else
    echo "Storage account $TF_STATE_STORAGE_ACCOUNT_NAME exists..."
fi

# Retrieve the storage account key
echo "Retrieving storage account key..."
ACCOUNT_KEY=$(az storage account keys list --resource-group $COMMON_RESOURCE_GROUP_NAME --account-name $TF_STATE_STORAGE_ACCOUNT_NAME --query [0].value -o tsv)
echo "Storage account key retrieved."

# Create a storage container (for the Terraform State)
if ( `az storage container exists --name $TF_STATE_CONTAINER_NAME --account-name $TF_STATE_STORAGE_ACCOUNT_NAME --account-key $ACCOUNT_KEY --query exists` == "true" );
then
    echo "Storage container $TF_STATE_CONTAINER_NAME exists..."
else
    echo "Creating $TF_STATE_CONTAINER_NAME storage container..."
    az storage container create --name $TF_STATE_CONTAINER_NAME --account-name $TF_STATE_STORAGE_ACCOUNT_NAME --account-key $ACCOUNT_KEY
    echo "Storage container $TF_STATE_CONTAINER_NAME created."
fi

# Create an Azure KeyVault
if ( `az keyvault list --query "[?name == '$KEYVAULT_NAME'].name | [0] == '$KEYVAULT_NAME'"` == "true" );
then
    echo "Key vault $KEYVAULT_NAME exists..."
else
    echo "Creating $KEYVAULT_NAME key vault..."
    az keyvault create -g $COMMON_RESOURCE_GROUP_NAME -l $LOCATION --name $KEYVAULT_NAME
    echo "Key vault $KEYVAULT_NAME created."
fi

# Store the Terraform State Storage Key into KeyVault
echo "Store storage access key into key vault secret..."
az keyvault secret set --name tfstate-storage-key --value $ACCOUNT_KEY --vault-name $KEYVAULT_NAME -o none

echo "Key vault secret created."

# Display information
echo "Azure Storage Account and KeyVault have been created."
echo "Run the following command to initialize Terraform to store its state into Azure Storage:"
echo "terraform init -backend-config=\"storage_account_name=$TF_STATE_STORAGE_ACCOUNT_NAME\" -backend-config=\"container_name=$TF_STATE_CONTAINER_NAME\" -backend-config=\"access_key=\$(az keyvault secret show --name tfstate-storage-key --vault-name $KEYVAULT_NAME --query value -o tsv)\" -backend-config=\"key=terraform-ref-architecture-tfstate\""