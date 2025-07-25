data "azurerm_data_protection_backup_vault" "main" {
  count               = var.backup_policy_id != null ? 1 : 0
  name                = local.parsed_backup_vault_id.name
  resource_group_name = local.parsed_backup_vault_id.resource_group_name
}

data "azurerm_subscription" "main" {}
