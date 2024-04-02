/*
  This Terraform file defines the outputs for an Azure Kubernetes Service (AKS) cluster deployment.
  The outputs provide information about the deployed AKS cluster, such as the resource group name,
  client key and certificate for authentication, CA certificate used by the cluster, username and
  password for authentication, Kubernetes configuration file (kubeconfig), and the host URL of the cluster.

  Outputs:
  - resource_group_name: The name of the resource group where the AKS cluster is deployed.
  - aks_client_key: The client key used for authenticating with the AKS cluster.
  - aks_client_certificate: The client certificate used for authenticating with the AKS cluster.
  - aks_cluster_ca_certificate: The CA (Certificate Authority) certificate used by the AKS cluster.
  - aks_cluster_username: The username for authenticating with the AKS cluster.
  - aks_cluster_password: The password for authenticating with the AKS cluster.
  - aks_kube_config: The Kubernetes configuration file (kubeconfig) for accessing the AKS cluster.
  - aks_host: The host URL of the AKS cluster.

  These outputs can be used to reference the created resources
  in other parts of the Terraform code or for external use.

*/

output "resource_group_name" {
  value       = module.aks.resource_group_name
  description = "The name of the resource group where the AKS cluster is deployed."
}

output "aks_client_key" {
  value       = module.aks.aks_client_key
  description = "The client key used for authenticating with the AKS cluster."
  sensitive   = true
}

output "aks_client_certificate" {
  value       = module.aks.aks_client_certificate
  description = "The client certificate used for authenticating with the AKS cluster."
  sensitive   = true
}

output "aks_cluster_ca_certificate" {
  value       = module.aks.aks_cluster_ca_certificate
  description = "The CA (Certificate Authority) certificate used by the AKS cluster."
  sensitive   = true
}

output "aks_cluster_username" {
  value       = module.aks.aks_cluster_username
  description = "The username for authenticating with the AKS cluster."
  sensitive   = true
}

output "aks_cluster_password" {
  value       = module.aks.aks_cluster_password
  description = "The password for authenticating with the AKS cluster."
  sensitive   = true
}

output "aks_kube_config" {
  value       = module.aks.aks_kube_config
  sensitive   = true
  description = "The Kubernetes configuration file (kubeconfig) for accessing the AKS cluster."
}

output "aks_host" {
  value       = module.aks.aks_host
  description = "The host URL of the AKS cluster."
  sensitive   = true
}
