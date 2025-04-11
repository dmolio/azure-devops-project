terraform {
  backend "azurerm" {
    resource_group_name  = "azure-devops-rg"
    storage_account_name = "tfstateazuredevops123"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }
}

provider "azurerm" {
  features {}
  client_id       = var.azure_client_id
  client_secret   = var.azure_client_secret
  tenant_id       = var.azure_tenant_id
  subscription_id = var.azure_subscription_id
}

variable "azure_client_id" {
  type        = string
  description = "Azure Service Principal Client ID"
  sensitive   = true
}

variable "azure_client_secret" {
  type        = string
  description = "Azure Service Principal Client Secret"
  sensitive   = true
}

variable "azure_tenant_id" {
  type        = string
  description = "Azure Tenant ID"
  sensitive   = true
}

variable "azure_subscription_id" {
  type        = string
  description = "Azure Subscription ID"
  sensitive   = true
}
