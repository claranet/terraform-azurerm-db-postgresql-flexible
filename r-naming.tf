resource "azurecaf_name" "postgresql" {
  name          = var.stack
  resource_type = "azurerm_postgresql_server"
  prefixes      = var.name_prefix == "" ? null : [local.name_prefix]
  suffixes      = compact([var.client_name, var.location_short, var.environment, local.name_suffix, var.use_caf_naming ? "" : "postgresql"])
  use_slug      = var.use_caf_naming
  clean_input   = true
  separator     = "-"
}

resource "azurecaf_name" "postgresql_dbs" {
  for_each = toset(var.databases_names)

  name          = var.stack
  resource_type = "azurerm_postgresql_database"
  prefixes      = var.name_prefix == "" ? null : [local.name_prefix]
  suffixes      = compact([var.client_name, var.location_short, var.environment, local.name_suffix, each.value, var.use_caf_naming ? "" : "postgresql"])
  use_slug      = var.use_caf_naming
  clean_input   = true
  separator     = "-"
}
