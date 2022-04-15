provider "postgresql" {
  host      = azurerm_postgresql_flexible_server.postgresql_flexible_server.fqdn
  port      = 5432
  username  = var.administrator_login
  password  = var.administrator_password
  sslmode   = "require"
  superuser = false

  alias = "create_users"
}
