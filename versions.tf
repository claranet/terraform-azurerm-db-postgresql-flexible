terraform {
  required_version = "> 1.1"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.22"
    }
    random = {
      source  = "hashicorp/random"
      version = ">= 3.0"
    }
    azurecaf = {
      source  = "aztfmod/azurecaf"
      version = "~> 1.2, >= 1.2.22"
    }
    postgresql = {
      source  = "cyrilgdn/postgresql"
      version = ">= 1.14"
    }
  }
}
