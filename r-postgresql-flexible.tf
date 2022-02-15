resource "azurerm_postgresql_flexible_server" "postgresql_flexible_server" {
  resource_group_name = var.resource_group_name
  name                = local.postgresql_flexible_server_name
  location            = var.location

  sku_name   = join("_", [lookup(local.tier_map, var.tier, "GeneralPurpose"), "Standard", var.size])
  storage_mb = var.storage_mb
  version    = var.postgre_version

  zone = var.zone

  dynamic "high_availability" {
    for_each = toset(var.standby_zone != null ? [var.standby_zone] : [])

    content {
      mode                      = "ZoneRedundant"
      standby_availability_zone = high_availability.value
    }
  }

  administrator_login    = var.administrator_login
  administrator_password = var.administrator_password

  backup_retention_days        = var.backup_retention_days
  geo_redundant_backup_enabled = var.geo_redundant_backup_enabled

  dynamic "maintenance_window" {
    for_each = toset(var.maintenance_window != null ? [var.maintenance_window] : [])

    content {
      day_of_week  = lookup(maintenance_window.value, "day_of_week", 0)
      start_hour   = lookup(maintenance_window.value, "start_hour", 0)
      start_minute = lookup(maintenance_window.value, "start_minute", 0)
    }
  }

  private_dns_zone_id = var.private_dns_zone_id
  delegated_subnet_id = var.delegated_subnet_id

  tags = merge(
    local.default_tags,
    var.extra_tags,
  )
}

resource "azurerm_postgresql_flexible_server_database" "postgresql_flexible_db" {
  for_each  = toset(var.databases_names)
  name      = var.use_caf_naming_for_databases ? azurecaf_name.postgresql_dbs[each.value].result : each.value
  server_id = azurerm_postgresql_flexible_server.postgresql_flexible_server.id
  charset   = lookup(var.databases_charset, each.value, "UTF8")
  collation = lookup(var.databases_collation, each.value, "en_US.UTF8")
}

resource "azurerm_postgresql_flexible_server_configuration" "postgresql_flexible_config" {
  for_each  = var.postgresql_configurations
  name      = each.key
  server_id = azurerm_postgresql_flexible_server.postgresql_flexible_server.id
  value     = each.value
}
