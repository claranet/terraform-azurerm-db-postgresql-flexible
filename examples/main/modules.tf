module "azure_region" {
  source  = "claranet/regions/azurerm"
  version = "x.x.x"

  azure_region = var.azure_region
}

module "rg" {
  source  = "claranet/rg/azurerm"
  version = "x.x.x"

  location    = module.azure_region.location
  client_name = var.client_name
  environment = var.environment
  stack       = var.stack
}

module "logs" {
  source  = "claranet/run-common/azurerm//modules/logs"
  version = "x.x.x"

  client_name         = var.client_name
  environment         = var.environment
  stack               = var.stack
  location            = module.azure_region.location
  location_short      = module.azure_region.location_short
  resource_group_name = module.rg.resource_group_name
}

module "postgresql_flexible" {
  source  = "claranet/db-postgresql-flexible/azurerm"
  version = "x.x.x"

  client_name    = var.client_name
  location       = module.azure_region.location
  location_short = module.azure_region.location_short
  environment    = var.environment
  stack          = var.stack

  resource_group_name = module.rg.resource_group_name

  tier               = "GeneralPurpose"
  size               = "D2s_v3"
  storage_mb         = 32768
  postgresql_version = 13

  allowed_cidrs = {
    "1" = "10.0.0.0/24"
    "2" = "12.34.56.78/32"
  }

  backup_retention_days        = 14
  geo_redundant_backup_enabled = true

  administrator_login    = var.administrator_login
  administrator_password = var.administrator_password

  databases_names     = ["mydatabase"]
  databases_collation = { mydatabase = "en_US.UTF8" }
  databases_charset   = { mydatabase = "UTF8" }

  maintenance_window = {
    "day_of_week" : 3
    "start_hour" : 3
    "start_minute" : 0
  }

  logs_destinations_ids = [
    module.logs.logs_storage_account_id,
    module.logs.log_analytics_workspace_id
  ]

  extra_tags = {
    foo = "bar"
  }
}
