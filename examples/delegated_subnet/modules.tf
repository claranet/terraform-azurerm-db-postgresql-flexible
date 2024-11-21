module "vnet" {
  source  = "claranet/vnet/azurerm"
  version = "x.x.x"

  location       = module.azure_region.location
  location_short = module.azure_region.location_short
  client_name    = var.client_name
  environment    = var.environment
  stack          = var.stack

  resource_group_name = module.rg.name

  cidrs = [var.vnet_cidr]
}

module "subnet" {
  source  = "claranet/subnet/azurerm"
  version = "x.x.x"

  location_short = module.azure_region.location_short
  client_name    = var.client_name
  environment    = var.environment
  stack          = var.stack

  resource_group_name = module.rg.name

  virtual_network_name = module.vnet.name

  cidrs = [var.subnet_cidr]

  service_endpoints = lookup(each.value, "service_endpoints", null)
  delegations = {
    "Microsoft.DBforPostgreSQL/flexibleServers" = [{
      name    = "Microsoft.DBforPostgreSQL/flexibleServers"
      actions = ["Microsoft.Network/virtualNetworks/subnets/join/action"]
    }]
  }
}

resource "azurerm_private_dns_zone" "postgres" {
  name                = format("%s-%s.postgres.database.azure.com", var.environment, var.stack)
  resource_group_name = module.rg.name
}

resource "azurerm_private_dns_zone_virtual_network_link" "postgres" {
  name                  = format("%s_dns_zone_postgres_%s", var.stack, var.environment)
  resource_group_name   = module.rg.name
  private_dns_zone_name = azurerm_private_dns_zone.postgres.name
  virtual_network_id    = module.vnet.id
}

module "postgresql_flexible" {
  source  = "claranet/db-postgresql-flexible/azurerm"
  version = "x.x.x"

  location       = module.azure_region.location
  location_short = module.azure_region.location_short
  client_name    = var.client_name
  environment    = var.environment
  stack          = var.stack

  resource_group_name = azurerm_private_dns_zone_virtual_network_link.postgres.resource_group_name

  tier               = "GeneralPurpose"
  size               = "D2s_v3"
  storage_mb         = 32768
  postgresql_version = 13

  allowed_cidrs = {
    "1" = "10.0.0.0/24"
    "2" = "12.34.56.78/32"
  }

  backup_retention_days        = 14
  geo_redundant_backup_enabled = true

  administrator_login    = var.administrator_login
  administrator_password = var.administrator_password

  databases = {
    mydatabase = {
      collation = "en_US.utf8"
      charset   = "UTF8"
    }
  }

  maintenance_window = {
    day_of_week  = 3
    start_hour   = 3
    start_minute = 0
  }

  private_dns_zone_id = azurerm_private_dns_zone.postgres.id
  delegated_subnet_id = module.subnet.id

  logs_destinations_ids = [
    module.logs.id,
    module.logs.storage_account_id,
  ]

  extra_tags = {
    foo = "bar"
  }
}
