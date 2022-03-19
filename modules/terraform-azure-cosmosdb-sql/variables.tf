variable "resource_group_name" {
  description = "Resource group name"
}

variable "resource_group_location" {
  description = "Resource group location"
}

variable "account_name" {
  description = "Cosmos DB account name"
}

variable "database_name" {
  description = "Cosmos DB database name"
  default     = ""
}

variable "collection_name" {
  description = "Cosmos DB collection name"
  default     = ""
}

variable "partition_key" {
  description = "Cosmos DB collection partition key"
  default     = ""
}
