# Azure Kubernetes Service Module

This module is responsible for the deployment of Azure Kubernetes Service inside a given environment. The module is developed in its own repository [here](https://github.com/venkatsunilm/terraform-azure-ref-aks-module).

The [environment-base](../environment-base/README.md) deployment has to be run before this one.

# Usage

Create a service principal for Azure Kubernetes Service, following [this documentation](https://docs.microsoft.com/en-us/azure/aks/kubernetes-service-principal).

OR the quick way to follow these steps to achieve the goal. 

1. az account show

{
  "environmentName": "AzureCloud",
  "homeTenantId": "TENANT_ID",
  "id": "SUBSCRIPTION_ID",
  "isDefault": true,
  "managedByTenants": [],
  "name": "Azure subscription venkat test",
  "state": "Enabled",
  "tenantId": "TENANT_ID",
  "user": {
    "name": "ve...@hotmail.com",
    "type": "user"
  }
}


2. Use the below command to create a RBAC
az ad sp create-for-rbac --name ServicePrincipalName --role Contributor --scopes /subscriptions/SUBSCRIPTION_ID/resourceGroups/tf-ref-dev-rg --sdk-auth

{
  "clientId": "CLIENT_ID",
  "clientSecret": "CLIENT_SECRET",
  "subscriptionId": "SUBSCRIPTION_ID",
  "tenantId": "TENANT_ID",
  ...
}

3. az ad sp show --id CLIENT_ID
Displays a json select the id. The id field in the response ("id": "OBJECT_ID") is the object ID of the service principal.

az account set --subscription SUBSCRIPTION_ID if not set yet. 

4. To generate the ssh keys use the below commands. 
ssh-keygen -t rsa -b 2048
cat ~/.ssh/id_rsa.pub

5. Add these environment variables to the terminal
export TF_VAR_service_principal_client_id="OBJECT_ID"
export TF_VAR_service_principal_client_secret="CLIENT_SECRET"
export TF_VAR_environment="dev"
export TF_VAR_location="westeurope"
export TF_VAR_kubernetes_version="1.29.2"
export TF_VAR_ssh_public_key="ssh-rsa ... sunilm@..itha"


Export service principal client id and client secret into Terraform environment variables:

```bash
export TF_VAR_service_principal_client_id="OBJECT_ID"
export TF_VAR_service_principal_client_secret="CLIENT_SECRET"
export TF_VAR_environment="dev"
export TF_VAR_location="westeurope"
export TF_VAR_kubernetes_version="1.29.2"
export TF_VAR_ssh_public_key="ssh-rsa AAAAB3N ... sunilm@..itha"
```

Then run the following script to deploy in the `deployment environment`.

```bash
ENVIRONMENT_NAME="dev"

# init terraform and backend storage
./init.sh $ENVIRONMENT_NAME

terraform apply -auto-approve
```