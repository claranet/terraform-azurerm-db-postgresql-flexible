resource "random_password" "db_passwords" {
  for_each = var.create_databases_users ? toset(var.databases_names) : toset([])

  special = "false"
  length  = 32
}

resource "postgresql_role" "db_user" {
  for_each = var.create_databases_users ? toset(var.databases_names) : toset([])

  name        = format("%s_user", each.value)
  login       = true
  password    = random_password.db_passwords[each.value].result
  create_role = true
  roles       = []
  search_path = concat([each.value, "$user"], lookup(var.database_users_search_path, each.value, []))

  provider = postgresql.create_users

  depends_on = [azurerm_postgresql_flexible_server_database.postgresql_flexible_db, azurerm_postgresql_flexible_server_firewall_rule.firewall_rules]
}

resource "postgresql_grant" "revoke_public" {
  for_each = var.create_databases_users ? toset(var.databases_names) : toset([])

  database    = azurerm_postgresql_flexible_server_database.postgresql_flexible_db[each.value].name
  role        = "public"
  schema      = "public"
  object_type = "schema"
  privileges  = []

  provider = postgresql.create_users

  depends_on = [azurerm_postgresql_flexible_server_database.postgresql_flexible_db, azurerm_postgresql_flexible_server_firewall_rule.firewall_rules]
}

resource "postgresql_schema" "db_schema" {
  for_each = var.create_databases_users ? toset(var.databases_names) : toset([])

  name     = each.value
  database = azurerm_postgresql_flexible_server_database.postgresql_flexible_db[each.value].name
  owner    = postgresql_role.db_user[each.value].name

  provider = postgresql.create_users
}

resource "postgresql_default_privileges" "user_tables_privileges" {
  for_each = var.create_databases_users ? toset(var.databases_names) : toset([])

  role     = postgresql_role.db_user[each.value].name
  database = each.value
  schema   = postgresql_schema.db_schema[each.value].name

  object_type = "table"
  owner       = var.administrator_login
  privileges = [
    "SELECT",
    "INSERT",
    "UPDATE",
    "DELETE",
    "TRUNCATE",
    "REFERENCES",
    "TRIGGER",
  ]

  provider = postgresql.create_users
}

resource "postgresql_default_privileges" "user_sequences_priviliges" {
  for_each = var.create_databases_users ? toset(var.databases_names) : toset([])

  role     = postgresql_role.db_user[each.value].name
  database = azurerm_postgresql_flexible_server_database.postgresql_flexible_db[each.value].name
  schema   = postgresql_schema.db_schema[each.value].name

  object_type = "sequence"
  owner       = var.administrator_login
  privileges = [
    "SELECT",
    "UPDATE",
    "USAGE",
  ]

  provider = postgresql.create_users
}

resource "postgresql_default_privileges" "user_functions_priviliges" {
  for_each = var.create_databases_users ? toset(var.databases_names) : toset([])

  role     = postgresql_role.db_user[each.value].name
  database = azurerm_postgresql_flexible_server_database.postgresql_flexible_db[each.value].name
  schema   = postgresql_schema.db_schema[each.value].name

  object_type = "function"
  owner       = var.administrator_login
  privileges = [
    "EXECUTE",
  ]

  provider = postgresql.create_users
}
