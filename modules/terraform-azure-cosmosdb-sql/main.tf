resource "azurerm_cosmosdb_account" "account" {
  name                = var.account_name
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  offer_type          = "Standard"

  consistency_policy {
    consistency_level       = "BoundedStaleness"
    max_interval_in_seconds = 300
    max_staleness_prefix    = 100000
  }

  geo_location {
    location          = var.resource_group_location
    failover_priority = 0
  }
}

resource "azurerm_cosmosdb_sql_database" "database" {
  count               = length(var.database_name) > 0 ? 1 : 0
  name                = var.database_name
  resource_group_name = azurerm_cosmosdb_account.account.resource_group_name
  account_name        = azurerm_cosmosdb_account.account.name
}

resource "azurerm_cosmosdb_sql_container" "collection" {
  count               = length(var.collection_name) > 0 ? 1 : 0
  name                = var.collection_name
  resource_group_name = azurerm_cosmosdb_account.account.resource_group_name
  account_name        = azurerm_cosmosdb_account.account.name
  database_name       = azurerm_cosmosdb_sql_database.database[0].name
  partition_key_path  = var.partition_key
}
