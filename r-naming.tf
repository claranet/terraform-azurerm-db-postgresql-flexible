data "azurecaf_name" "postgresql_flexible_server" {
  name          = var.stack
  resource_type = "azurerm_postgresql_flexible_server"
  prefixes      = var.name_prefix == "" ? null : [local.name_prefix]
  suffixes      = compact([var.client_name, var.location_short, var.environment, local.name_suffix, var.use_caf_naming ? "" : "psqlf"])
  use_slug      = var.use_caf_naming
  clean_input   = true
  separator     = "-"
}

data "azurecaf_name" "postgresql_flexible_dbs" {
  for_each = toset(var.databases_names)

  name          = var.stack
  resource_type = "azurerm_postgresql_flexible_server_database"
  prefixes      = var.name_prefix == "" ? null : [local.name_prefix]
  suffixes      = compact([var.client_name, var.location_short, var.environment, local.name_suffix, each.value, var.use_caf_naming ? "" : "psqlf"])
  use_slug      = var.use_caf_naming
  clean_input   = true
  separator     = "-"
}
