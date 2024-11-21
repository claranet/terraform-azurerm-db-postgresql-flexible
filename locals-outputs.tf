locals {
  databases_ids = {
    for key, value in azurerm_postgresql_flexible_server_database.main : key => value.id
  }

  databases_names = {
    for key, value in azurerm_postgresql_flexible_server_database.main : key => value.name
  }

  firewall_rules_ids = {
    for key, value in azurerm_postgresql_flexible_server_firewall_rule.main : key => value.id
  }

  configurations = {
    for key, value in azurerm_postgresql_flexible_server_configuration.main : key => value.value
  }
}
