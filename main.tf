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

module "cosmosdb" {
  source                  = "./modules/terraform-azure-cosmosdb"
  resource_group_name     = azurerm_resource_group.rg.name
  resource_group_location = azurerm_resource_group.rg.location
  account_name            = var.cosmosdb_account_name
  database_name           = var.cosmosdb_database_name
  collection_name         = var.cosmosdb_database_collection_name
  partition_key           = var.cosmosdb_database_collection_partition_key
}

module "function_app" {
  source                    = "./modules/terraform-azure-function-app"
  resource_group_name       = azurerm_resource_group.rg.name
  resource_group_location   = azurerm_resource_group.rg.location
  storage_account_name      = var.storage_account_name
  storage_service_plan_name = var.storage_service_plan_name
  function_app_name         = var.function_app_name
  depends_on = [
    module.cosmosdb.cosmosdb_account_name
  ]
}
