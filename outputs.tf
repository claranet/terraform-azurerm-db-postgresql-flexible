output "postgresql_flexible_administrator_login" {
  description = "Administrator login for PostgreSQL server."
  value       = azurerm_postgresql_flexible_server.postgresql_flexible_server.administrator_login
  sensitive   = true
}

output "postgresql_flexible_databases_names" {
  description = "Map of databases names."
  value       = azurerm_postgresql_flexible_server_database.postgresql_flexible_db
}

output "postgresql_flexible_database_ids" {
  description = "The map of all database resource ids."
  value       = azurerm_postgresql_flexible_server_database.postgresql_flexible_db
}

output "postgresql_flexible_firewall_rules" {
  description = "Map of PostgreSQL created rules."
  value       = azurerm_postgresql_flexible_server_firewall_rule.firewall_rules
}

output "postgresql_flexible_fqdn" {
  description = "FQDN of the PostgreSQL server."
  value       = azurerm_postgresql_flexible_server.postgresql_flexible_server.fqdn
}

output "postgresql_flexible_server_id" {
  description = "PostgreSQL server ID."
  value       = azurerm_postgresql_flexible_server.postgresql_flexible_server.id
}

output "postgresql_flexible_configurations" {
  description = "The map of all postgresql configurations set."
  value       = azurerm_postgresql_flexible_server_configuration.postgresql_flexible_config
}

output "postgresql_users_credentials" {
  description = "Map of passwords for databases users."
  value       = var.create_databases_users ? { for db in var.databases_names : format("%s_user", db) => random_password.db_passwords[db].result } : {}
  sensitive   = true
}
