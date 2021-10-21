terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.71.0"
    }
  }
}

provider "azurerm" {
  features {}
  client_id       = ""
  tenant_id       = ""
  subscription_id = ""
  client_secret   = ""
}

