resource "azurerm_data_protection_backup_instance_postgresql_flexible_server" "main" {
  count = var.backup_policy_id != null ? 1 : 0

  name             = local.name
  backup_policy_id = var.backup_policy_id
  location         = var.location
  server_id        = azurerm_postgresql_flexible_server.main.id
  vault_id         = local.parsed_backup_policy_id.parent_id
}

resource "azurerm_role_assignment" "reader" {
  count = var.backup_policy_id != null ? 1 : 0

  principal_id         = data.azurerm_data_protection_backup_vault.main[0].identity[0].principal_id
  scope                = "${data.azurerm_subscription.main.id}/resourceGroups/${azurerm_postgresql_flexible_server.main.resource_group_name}"
  role_definition_name = "Reader"
}

resource "azurerm_role_assignment" "main" {
  count = var.backup_policy_id != null ? 1 : 0

  principal_id         = data.azurerm_data_protection_backup_vault.main[0].identity[0].principal_id
  scope                = azurerm_postgresql_flexible_server.main.id
  role_definition_name = "PostgreSQL Flexible Server Long Term Retention Backup Role"
}
