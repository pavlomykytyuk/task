terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.116.0"
    }
  }

  backend "azurerm" {
    resource_group_name  = "backend-rg"
    storage_account_name = "gen1demotfstate"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }

  #  required_version = "latest"
}

provider "azurerm" {
  features {
    resource_group {
      # This flag is set to mitigate an open bug in Terraform. As soon as this is fixed, we should remove this.
      prevent_deletion_if_contains_resources = false
    }
  }
}
