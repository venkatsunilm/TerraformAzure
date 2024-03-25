# Core Module

This module is responsible for the deployment for all the core components and resources for a given environment, like:

- The resource group - "tf-${var.environment}-rg"
- The virtual network and subnets for aks and backend
- The peerings for aks2backend and backend2aks

# Usage

```bash
ENVIRONMENT_NAME="dev"
LOCATION="westeurope"

# init terraform and backend storage
./init.sh $ENVIRONMENT_NAME

terraform apply -var environment=$ENVIRONMENT_NAME -var location=$LOCATION -auto-approve
```