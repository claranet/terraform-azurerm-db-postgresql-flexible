resource "azurerm_postgresql_virtual_network_rule" "vnet_rules" {
  for_each            = var.vnet_rules
  name                = each.key
  resource_group_name = var.resource_group_name
  server_name         = azurerm_postgresql_flexible_server.postgresql_flexible_server.name
  subnet_id           = each.value
}
