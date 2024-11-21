resource "random_password" "administrator_password" {
  count = var.administrator_password == null ? 1 : 0

  length  = 32
  special = true
}

resource "azurerm_postgresql_flexible_server" "main" {
  name     = local.name
  location = var.location

  resource_group_name = var.resource_group_name

  administrator_login    = var.administrator_login
  administrator_password = local.administrator_password

  sku_name          = join("_", [lookup(local.tier_map, var.tier, "GeneralPurpose"), "Standard", var.size])
  storage_mb        = var.storage_mb
  auto_grow_enabled = var.auto_grow_enabled
  version           = var.postgresql_version

  delegated_subnet_id = var.delegated_subnet_id
  private_dns_zone_id = var.private_dns_zone_id

  public_network_access_enabled = var.public_network_access_enabled

  backup_retention_days        = var.backup_retention_days
  geo_redundant_backup_enabled = var.geo_redundant_backup_enabled

  dynamic "high_availability" {
    for_each = toset(var.standby_zone != null && var.tier != "Burstable" ? [var.standby_zone] : [])
    content {
      mode                      = "ZoneRedundant"
      standby_availability_zone = high_availability.value
    }
  }

  dynamic "maintenance_window" {
    for_each = var.maintenance_window[*]
    content {
      day_of_week  = maintenance_window.value.day_of_week
      start_hour   = maintenance_window.value.start_hour
      start_minute = maintenance_window.value.start_minute
    }
  }

  dynamic "authentication" {
    for_each = var.authentication[*]
    content {
      active_directory_auth_enabled = authentication.value.active_directory_auth_enabled
      password_auth_enabled         = authentication.value.password_auth_enabled
      tenant_id                     = authentication.value.tenant_id
    }
  }

  zone = var.zone

  tags = merge(local.default_tags, var.extra_tags)

  lifecycle {
    precondition {
      condition     = var.private_dns_zone_id != null && var.delegated_subnet_id != null || var.private_dns_zone_id == null && var.delegated_subnet_id == null
      error_message = "var.private_dns_zone_id and var.delegated_subnet_id should either both be set or none of them."
    }
  }
}

moved {
  from = azurerm_postgresql_flexible_server.postgresql_flexible_server
  to   = azurerm_postgresql_flexible_server.main
}

resource "azurerm_postgresql_flexible_server_database" "main" {
  for_each = var.databases

  name      = each.key
  server_id = azurerm_postgresql_flexible_server.main.id
  charset   = each.value.charset
  collation = each.value.collation
}

moved {
  from = azurerm_postgresql_flexible_server_database.postgresql_flexible_db
  to   = azurerm_postgresql_flexible_server_database.main
}

resource "azurerm_postgresql_flexible_server_firewall_rule" "main" {
  for_each = var.delegated_subnet_id == null ? var.allowed_cidrs : {}

  name             = each.key
  server_id        = azurerm_postgresql_flexible_server.main.id
  start_ip_address = cidrhost(each.value, 0)
  end_ip_address   = cidrhost(each.value, -1)
}

moved {
  from = azurerm_postgresql_flexible_server_firewall_rule.firewall_rules
  to   = azurerm_postgresql_flexible_server_firewall_rule.main
}

resource "azurerm_postgresql_flexible_server_configuration" "main" {
  for_each = var.configurations

  name      = each.key
  server_id = azurerm_postgresql_flexible_server.main.id
  value     = each.value
}

moved {
  from = azurerm_postgresql_flexible_server_configuration.postgresql_flexible_config
  to   = azurerm_postgresql_flexible_server_configuration.main
}
