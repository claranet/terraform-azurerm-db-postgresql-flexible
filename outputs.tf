output "resource" {
  description = "Azure PostgreSQL server resource object."
  value       = azurerm_postgresql_flexible_server.main
}

output "resource_database" {
  description = "Azure PostgreSQL database resource object."
  value       = azurerm_postgresql_flexible_server_database.main
}

output "resource_configuration" {
  description = "Azure PostgreSQL configuration resource object."
  value       = azurerm_postgresql_flexible_server_configuration.main
}

output "resource_firewall_rule" {
  description = "Azure PostgreSQL server firewall rule resource object."
  value       = azurerm_postgresql_flexible_server_firewall_rule.main
}

output "module_diagnostics" {
  description = "Diagnostics settings module outputs."
  value       = module.diagnostics
}

output "id" {
  description = "ID of the Azure PostgreSQL Flexible server."
  value       = azurerm_postgresql_flexible_server.main.id
}

output "name" {
  description = "Name of the Azure PostgreSQL Flexible server."
  value       = local.name
}

output "administrator_login" {
  description = "Administrator login for PostgreSQL Flexible server."
  value       = azurerm_postgresql_flexible_server.main.administrator_login
  sensitive   = true
}

output "administrator_password" {
  description = "Administrator password for PostgreSQL Flexible server."
  value       = local.administrator_password
  sensitive   = true
}

output "databases_names" {
  description = "Map of databases names."
  value       = azurerm_postgresql_flexible_server_database.main
}

output "database_ids" {
  description = "The map of all database resource IDs."
  value       = azurerm_postgresql_flexible_server_database.main
}

output "firewall_rules" {
  description = "Map of PostgreSQL created rules."
  value       = azurerm_postgresql_flexible_server_firewall_rule.main
}

output "fqdn" {
  description = "FQDN of the PostgreSQL server."
  value       = azurerm_postgresql_flexible_server.main.fqdn
}

output "server_id" {
  description = "PostgreSQL server ID."
  value       = azurerm_postgresql_flexible_server.main.id
}

output "configurations" {
  description = "The map of all PostgreSQL configurations set."
  value       = azurerm_postgresql_flexible_server_configuration.main
}

output "terraform_module" {
  description = "Information about this Terraform module"
  value = {
    name       = "db-postgresql-flexible"
    provider   = "azurerm"
    maintainer = "claranet"
  }
}
