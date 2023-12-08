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
  source  = "claranet/run/azurerm//modules/logs"
  version = "x.x.x"

  client_name         = var.client_name
  environment         = var.environment
  stack               = var.stack
  location            = module.azure_region.location
  location_short      = module.azure_region.location_short
  resource_group_name = module.rg.resource_group_name
}

resource "random_password" "admin_password" {
  special = "false"
  length  = 32
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

  administrator_login    = "azureadmin"
  administrator_password = random_password.admin_password.result

  databases = {
    mydatabase = {
      collation = "en_US.UTF8"
      charset   = "UTF8"
    }
  }

  maintenance_window = {
    day_of_week  = 3
    start_hour   = 3
    start_minute = 0
  }

  logs_destinations_ids = [
    module.logs.logs_storage_account_id,
    module.logs.log_analytics_workspace_id
  ]

  extra_tags = {
    foo = "bar"
  }
}

provider "postgresql" {
  host      = module.postgresql_flexible.postgresql_flexible_fqdn
  port      = 5432
  username  = module.postgresql_flexible.postgresql_flexible_administrator_login
  password  = module.postgresql_flexible.postgresql_flexible_administrator_password
  sslmode   = "require"
  superuser = false
}

module "postgresql_users" {
  source  = "claranet/users/postgresql"
  version = "x.x.x"

  for_each = module.postgresql_flexible.postgresql_flexible_databases_names

  administrator_login = module.postgresql_flexible.postgresql_flexible_administrator_login

  database = each.key
}

module "postgresql_configuration" {
  source  = "claranet/database-configuration/postgresql"
  version = "x.x.x"

  for_each = module.postgresql_flexible.postgresql_flexible_databases_names

  administrator_login = module.postgresql_flexible.postgresql_flexible_administrator_login

  database_admin_user = module.postgresql_users[each.key].user
  database            = each.key
  schema_name         = each.key
}
