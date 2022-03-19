terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.99.0"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.resource_group_location
}

module "cosmosdb_account" {
  source                  = "./modules/terraform-azure-cosmosdb-sql"
  resource_group_name     = azurerm_resource_group.rg.name
  resource_group_location = azurerm_resource_group.rg.location
  account_name            = var.cosmosdb_account_name
  database_name           = var.cosmosdb_database_name
  collection_name         = var.cosmosdb_database_collection_name
  partition_key           = var.cosmosdb_database_collection_partition_key
}
