locals {
  tier_map = {
    "GeneralPurpose"  = "GP"
    "Burstable"       = "B"
    "MemoryOptimized" = "MO"
  }

  administrator_password  = coalesce(var.administrator_password, one(random_password.administrator_password[*].result))
  parsed_backup_policy_id = try(provider::azapi::parse_resource_id("Microsoft.DataProtection/backupVaults/backupPolicies", var.backup_policy_id), null)
  parsed_backup_vault_id  = try(provider::azapi::parse_resource_id("Microsoft.DataProtection/backupVaults", local.parsed_backup_policy_id.parent_id), null)

  recommended_configurations = {
    "log_lock_waits"                        = "ON"
    "log_checkpoints"                       = "ON"
    "log_connections"                       = "ON"
    "log_disconnections"                    = "ON"
    "log_temp_files"                        = "0"
    "logfiles.download_enable"              = "ON"
    "metrics.autovacuum_diagnostics"        = "ON"
    "metrics.collector_database_activity"   = "ON"
    "pg_stat_statements.max"                = "10000"
    "pg_stat_statements.track"              = "ALL"
    "pg_qs.query_capture_mode"              = "TOP"
    "pgms_wait_sampling.query_capture_mode" = "ALL"
    "track_io_timing"                       = "ON"
  }

  configurations = merge(
    var.recommended_configurations_enabled ? local.recommended_configurations : {},
    var.configurations
  )
}
