locals {
  tier_map = {
    "GeneralPurpose"  = "GP"
    "Burstable"       = "B"
    "MemoryOptimized" = "MO"
  }

  administrator_password  = coalesce(var.administrator_password, one(random_password.administrator_password[*].result))
  parsed_backup_policy_id = try(provider::azapi::parse_resource_id("Microsoft.DataProtection/backupVaults/backupPolicies", var.backup_policy_id), null)
  parsed_backup_vault_id  = try(provider::azapi::parse_resource_id("Microsoft.DataProtection/backupVaults", local.parsed_backup_policy_id.parent_id), null)
}
