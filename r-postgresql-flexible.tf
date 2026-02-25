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
  storage_tier      = var.storage_tier
  auto_grow_enabled = var.auto_grow_enabled
  version           = var.postgresql_version

  delegated_subnet_id = one(var.delegated_subnet[*].id)
  private_dns_zone_id = one(var.private_dns_zone[*].id)

  public_network_access_enabled = var.public_network_access_enabled

  backup_retention_days        = var.backup_retention_days
  geo_redundant_backup_enabled = var.geo_redundant_backup_enabled

  dynamic "high_availability" {
    for_each = var.high_availability[*]
    content {
      mode                      = high_availability.value.mode
      standby_availability_zone = high_availability.value.mode == "SameZone" ? var.zone : high_availability.value.standby_availability_zone
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
    ignore_changes = [
      high_availability[0].standby_availability_zone,
      zone
    ]
    precondition {
      condition     = (var.tier != "Burstable") || (var.tier == "Burstable" && var.high_availability == null)
      error_message = "var.high_availability should be null for Burstable tier."
    }
    prevent_destroy = true
  }
}

moved {
  from = azurerm_postgresql_flexible_server.postgresql_flexible_server
  to   = azurerm_postgresql_flexible_server.main
}

# issue https://github.com/hashicorp/terraform-provider-azurerm/issues/22936
resource "terraform_data" "collation_case_hack" {
  for_each = var.databases

  triggers_replace = [lower(each.value.charset), lower(each.value.collation)]
}

resource "azurerm_postgresql_flexible_server_database" "main" {
  for_each = var.databases

  name      = each.key
  server_id = azurerm_postgresql_flexible_server.main.id
  charset   = each.value.charset
  collation = each.value.collation

  lifecycle {
    ignore_changes       = [charset, collation]
    replace_triggered_by = [terraform_data.collation_case_hack[each.key]]
  }
}

moved {
  from = azurerm_postgresql_flexible_server_database.postgresql_flexible_db
  to   = azurerm_postgresql_flexible_server_database.main
}

resource "azurerm_postgresql_flexible_server_firewall_rule" "main" {
  for_each = var.delegated_subnet == null ? var.allowed_cidrs : {}

  name             = each.key
  server_id        = azurerm_postgresql_flexible_server.main.id
  start_ip_address = cidrhost(each.value, 0)
  end_ip_address   = cidrhost(each.value, -1)
}

moved {
  from = azurerm_postgresql_flexible_server_firewall_rule.firewall_rules
  to   = azurerm_postgresql_flexible_server_firewall_rule.main
}

# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mysql_flexible_server_firewall_rule#example-usage-allow-access-to-azure-services
# https://learn.microsoft.com/en-us/azure/postgresql/flexible-server/security-firewall-rules#programmatically-manage-firewall-rules
resource "azurerm_postgresql_flexible_server_firewall_rule" "azure_services" {
  count = var.delegated_subnet == null && var.azure_services_access_enabled ? 1 : 0

  name             = "Azure-Services"
  server_id        = azurerm_postgresql_flexible_server.main.id
  start_ip_address = "0.0.0.0"
  end_ip_address   = "0.0.0.0"
}

resource "azurerm_postgresql_flexible_server_configuration" "main" {
  for_each = local.configurations

  name      = each.key
  server_id = azurerm_postgresql_flexible_server.main.id
  value     = each.value
}

moved {
  from = azurerm_postgresql_flexible_server_configuration.postgresql_flexible_config
  to   = azurerm_postgresql_flexible_server_configuration.main
}
