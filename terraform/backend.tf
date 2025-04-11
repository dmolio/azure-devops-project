terraform {
  backend "azurerm" {
    resource_group_name  = "azure-devops-rg"
    storage_account_name = "tfstateazuredevops123"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }
}
