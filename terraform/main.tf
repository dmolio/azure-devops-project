terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

# Configure the Azure provider
# Moved to backend.tf
/*
provider "azurerm" {
  features {}
}
*/

resource "azurerm_resource_group" "rg" {
  name     = "azure-devops-rg"
  location = "East US"
}

resource "azurerm_virtual_network" "vnet" {
  name                = "azure-devops-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_subnet" "subnet" {
  name                 = "aks-subnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

# Placeholder for AKS cluster configuration
# This will be expanded based on specific requirements

resource "azurerm_kubernetes_cluster" "aks" {
  name                = "azure-devops-aks"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = "azuredevopsaks"

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_D2_v2"
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    Environment = "Dev"
  }
}
