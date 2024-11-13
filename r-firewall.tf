resource "azurerm_postgresql_flexible_server_firewall_rule" "main" {
  for_each = var.delegated_subnet_id == null ? var.allowed_cidrs : {}

  name             = each.key
  server_id        = azurerm_postgresql_flexible_server.main.id
  start_ip_address = cidrhost(each.value, 0)
  end_ip_address   = cidrhost(each.value, -1)
}
