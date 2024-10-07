terraform {
  required_version = ">= 1.0.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 2.91.0"
    }
    postgresql = {
      source  = "cyrilgdn/postgresql"
      version = ">= 1.14"
    }
  }
}

provider "azurerm" {
  features {}
}
