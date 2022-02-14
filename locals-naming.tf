locals {
  name_prefix  = var.name_prefix != "" ? replace(var.name_prefix, "/[a-z0-9]$/", "$0-") : ""
  default_name = lower("${local.name_prefix}${var.stack}-${var.client_name}-${var.location_short}-${var.environment}")

  postgresql_flexible_server_name = coalesce(var.custom_server_name, "${local.default_name}-postgresqlflexible")
}