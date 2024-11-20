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
  description = "ID of the Azure PostgreSQL Flexible Server."
  value       = azurerm_postgresql_flexible_server.main.id
}

output "name" {
  description = "Name of the Azure PostgreSQL Flexible Server."
  value       = azurerm_postgresql_flexible_server.main.name
}

output "fqdn" {
  description = "FQDN of the PostgreSQL Flexible Server."
  value       = azurerm_postgresql_flexible_server.main.fqdn
}

output "administrator_login" {
  description = "Administrator login for PostgreSQL Flexible Server."
  value       = azurerm_postgresql_flexible_server.main.administrator_login
}

output "administrator_password" {
  description = "Administrator password for PostgreSQL Flexible Server."
  value       = azurerm_postgresql_flexible_server.main.administrator_password
  sensitive   = true
}

output "database_ids" {
  description = "Map of databases IDs."
  value       = local.databases_ids
}

output "databases_names" {
  description = "Map of databases names."
  value       = local.databases_names
}

output "firewall_rules_ids" {
  description = "Map of firewall rules IDs."
  value       = local.firewall_rules_ids
}

output "configurations" {
  description = "Map of all PostgreSQL configurations."
  value       = local.configurations
}

output "terraform_module" {
  description = "Information about this Terraform module."
  value = {
    name       = "db-postgresql-flexible"
    provider   = "azurerm"
    maintainer = "claranet"
  }
}
