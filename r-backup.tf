resource "azurerm_data_protection_backup_instance_postgresql_flexible_server" "main" {
  count = var.backup_policy_id != null ? 1 : 0

  name             = local.name
  backup_policy_id = var.backup_policy_id
  location         = var.location
  server_id        = azurerm_postgresql_flexible_server.main.id
  vault_id         = local.parsed_backup_policy_id.parent_id
}
