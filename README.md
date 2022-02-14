# Azure Managed DB - PostgreSQL flexible

[![Changelog](https://img.shields.io/badge/changelog-release-green.svg)](CHANGELOG.md) [![Notice](https://img.shields.io/badge/notice-copyright-yellow.svg)](NOTICE) [![Apache V2 License](https://img.shields.io/badge/license-Apache%20V2-orange.svg)](LICENSE) [![TF Registry](https://img.shields.io/badge/terraform-registry-blue.svg)](https://registry.terraform.io/modules/claranet/db-postgresql/azurerm/)

This module creates an [Azure PostgreSQL Flexible server](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/postgresql_flexible_server) with [databases](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/postgresql_flexible_server_database) along with logging activated and [firewall rules](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/postgresql_flexible_server_firewall_rule) and [virtual network rules](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/postgresql_virtual_network_rule).
A user is created for each databases created with this module. This module does not allow users to create new objects in the public schema regarding the [CVE-2018-1058](https://wiki.postgresql.org/wiki/A_Guide_to_CVE-2018-1058%3A_Protect_Your_Search_Path#Do_not_allow_users_to_create_new_objects_in_the_public_schema).

## Requirements

* [Ansible](https://docs.ansible.com/ansible/latest/index.html) >= 2.4
* Library [libpq-dev](https://pypi.org/project/libpq-dev/) and PostgreSQL adapter [python-psycopg2](https://pypi.org/project/psycopg2/)

<!-- BEGIN_TF_DOCS -->
## Global versioning rule for Claranet Azure modules

| Module version | Terraform version | AzureRM version |
| -------------- | ----------------- | --------------- |
| >= 5.x.x       | 0.15.x & 1.0.x    | >= 2.0          |
| >= 4.x.x       | 0.13.x            | >= 2.0          |
| >= 3.x.x       | 0.12.x            | >= 2.0          |
| >= 2.x.x       | 0.12.x            | < 2.0           |
| <  2.x.x       | 0.11.x            | < 2.0           |

## Usage

This module is optimized to work with the [Claranet terraform-wrapper](https://github.com/claranet/terraform-wrapper) tool
which set some terraform variables in the environment needed by this module.
More details about variables set by the `terraform-wrapper` available in the [documentation](https://github.com/claranet/terraform-wrapper#environment).

```hcl
module "azure_region" {
  source  = "claranet/regions/azurerm"
  version = "x.x.x"

  azure_region = var.azure_region
}

module "rg" {
  source  = "claranet/rg/azurerm"
  version = "x.x.x"

  location    = module.azure_region.location
  client_name = var.client_name
  environment = var.environment
  stack       = var.stack
}

module "postgresql_flexible" {
  source  = "claranet/db-postgresql-flexible/azurerm"
  version = "x.x.x"

  client_name    = var.client_name
  location       = module.azure_region.location
  location_short = module.azure_region.location_short
  environment    = var.environment
  stack          = var.stack

  resource_group_name = module.rg.resource_group_name

  tier        = "GeneralPurpose"
  size        = "D2s_v3"
  storage_mb  = 32768
  version     = 13

  allowed_cidrs = {
    "1" = "10.0.0.0/24"
    "2" = "12.34.56.78/32"
  }

  backup_retention_days        = 14
  geo_redundant_backup_enabled = true

  administrator_login          = var.administrator_login
  administrator_password       = var.administrator_password

  databases_names     = ["mydatabase"]
  databases_collation = { mydatabase = "en-US.UTF8" }
  databases_charset   = { mydatabase = "UTF8" }

  extra_tags = {
    foo = "bar"
  }
}

```

## Providers

| Name | Version |
|------|---------|
| azurerm | >= 2.7 |
| null | >= 3.0 |
| random | >= 3.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_monitor_diagnostic_setting.log_settings_log_analytics](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_diagnostic_setting) | resource |
| [azurerm_monitor_diagnostic_setting.log_settings_storage](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_diagnostic_setting) | resource |
| [azurerm_postgresql_flexible_server_configuration.postgresql_flexible_config](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/postgresql_flexible_server_configuration) | resource |
| [azurerm_postgresql_flexible_server_database.postgresql_flexible_db](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/postgresql_flexible_server_database) | resource |
| [azurerm_postgresql_flexible_server_firewall_rule.firewall_rules](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/postgresql_flexible_server_firewall_rule) | resource |
| [azurerm_postgresql_flexible_server.postgresql_flexible_server](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/postgresql_flexible_server) | resource |
| [azurerm_postgresql_virtual_network_rule.vnet_rules](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/postgresql_virtual_network_rule) | resource |
| [null_resource.db_users](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [random_password.db_passwords](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| administrator\_login | PostgreSQL administrator login. | `string` | n/a | yes |
| administrator\_password | PostgreSQL administrator password. Strong Password : https://docs.microsoft.com/en-us/sql/relational-databases/security/strong-passwords?view=sql-server-2017. | `string` | n/a | yes |
| allowed\_cidrs | Map of authorized cidrs. | `map(string)` | n/a | yes |
| backup\_retention\_days | Backup retention days for the PostgreSQL Flexible Server (Between 7 and 35 days). | `number` | `7` | no |
| client\_name | Name of client. | `string` | n/a | yes |
| create\_databases\_users | True to create a user named <db>\_user per database with generated password and role db\_owner. | `bool` | `true` | no |
| custom\_server\_name | Custom Server Name identifier. | `string` | `""` | no |
| databases\_charset | Valid PostgreSQL charset : https://www.postgresql.org/docs/current/multibyte.html#CHARSET-TABLE. | `map(string)` | `{}` | no |
| databases\_collation | Valid PostgreSQL collation : http://www.postgresql.cn/docs/13/collation.html. - be careful about https://docs.microsoft.com/en-us/windows/win32/intl/locale-names?redirectedfrom=MSDN | `map(string)` | `{}` | no |
| databases\_names | List of databases names to create. | `list(string)` | n/a | yes |
| delegated\_subnet\_id | Id of the subnet to create the PostgreSQL Flexible Server. (Should not have any resource deployed in) | `string` | n/a | no |
| enable\_logs\_to\_log\_analytics | Boolean flag to specify whether the logs should be sent to Log Analytics. | `bool` | `false` | no |
| enable\_logs\_to\_storage | Boolean flag to specify whether the logs should be sent to the Storage Account. | `bool` | `false` | no |
| environment | Name of application's environnement. | `string` | n/a | yes |
| extra\_tags | Map of custom tags. | `map(string)` | `{}` | no |
| geo\_redundant\_backup\_enabled | Enable Geo Redundant Backup for the PostgreSQL Flexible Server. | `bool` | `true` | no |
| location | Azure location. | `string` | n/a | yes |
| location\_short | Short string for Azure location. | `string` | n/a | yes |
| logs\_log\_analytics\_workspace\_id | Log Analytics Workspace id for logs. | `string` | `""` | no |
| maintenance\_window | Map of maintenance window configuration | `map(number)` | `{}` | no |
| logs\_storage\_account\_id | Storage Account id for logs. | `string` | `""` | no |
| name\_prefix | Optional prefix for PostgreSQL server name. | `string` | `""` | no |
| postgresql\_configurations | PostgreSQL configurations to enable. | `map(string)` | `{}` | no |
| postgresql\_version | Version of PostgreSQL Flexible Server. | `number` | `` | yes |
| private\_dns\_zone\_id | ID of the private DNS zone to create The PostgreSQL Flexible Server. | `string` | `""` | no |
| resource\_group\_name | Name of the application ressource group, herited from infra module. | `string` | n/a | yes |
| size | Size for PostgreSQL Flexible server sku - number of vCores : https://docs.microsoft.com/en-us/azure/postgresql/flexible-server/concepts-compute-storage. | `string` |`"D2ds_v4"` | yes |
| stack | Name of application stack. | `string` | n/a | yes |
| standby_zone | Specify availability-zone to enable high_availability and create standby PostgreSQL Flexible Server. | `number` | 2 | no |
| storage\_mb | Storage allowed for PostgresSQL Flexible server. Possible values : https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/postgresql_flexible_server#storage_mb. | `number` | `32768` | no |
| tier | Tier for PostgreSQL Flexible server sku : https://docs.microsoft.com/en-us/azure/postgresql/flexible-server/concepts-compute-storage. Possible values are: GeneralPurpose, Burstable, MemoryOptimized. | `string` | `"GeneralPurpose"` | no |
| vnet\_rules | Map of vnet rules to create. | `map(string)` | `{}` | no |
| zone | Specify availability-zone for PostgreSQL Flexible main Server. | `number` | `1` | no |

## Outputs

| Name | Description |
|------|-------------|
| postgresql\_flexible\_administrator\_login | Administrator login for PostgreSQL server. |
| postgresql\_flexible\_configurations | The map of all postgresql configurations set. |
| postgresql\_flexible\_database\_ids | The map of all database resource ids. |
| postgresql\_flexible\_databases\_names | Map of databases names. |
| postgresql\_flexible\_firewall\_rules | Map of PostgreSQL created rules. |
| postgresql\_flexible\_fqdn | FQDN of the PostgreSQL server. |
| postgresql\_flexible\_server\_id | PostgreSQL server ID. |
| postgresql\_users\_passwords | Map of passwords for databases users. |
| postgresql\_flexible\_vnet\_rules | The map of all vnet rules. |
<!-- END_TF_DOCS -->
## Related documentation

Microsoft Azure documentation: [docs.microsoft.com/fr-fr/azure/postgresql/flexible-server/](https://docs.microsoft.com/fr-fr/azure/postgresql/flexible-server/)
