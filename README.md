# Azure Managed Database - PostgreSQL flexible

[![Changelog](https://img.shields.io/badge/changelog-release-green.svg)](CHANGELOG.md) [![Notice](https://img.shields.io/badge/notice-copyright-blue.svg)](NOTICE) [![Apache V2 License](https://img.shields.io/badge/license-Apache%20V2-orange.svg)](LICENSE) [![OpenTofu Registry](https://img.shields.io/badge/opentofu-registry-yellow.svg)](https://search.opentofu.org/module/claranet/db-postgresql/azurerm/)

This module creates an [Azure PostgreSQL Flexible server](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/postgresql_flexible_server) with [databases](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/postgresql_flexible_server_database) along with logging activated  [firewall rules](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/postgresql_flexible_server_firewall_rule).
A user is created for each databases created with this module. This module does not allow users to create new objects in the public schema regarding the [CVE-2018-1058](https://wiki.postgresql.org/wiki/A_Guide_to_CVE-2018-1058%3A_Protect_Your_Search_Path#Do_not_allow_users_to_create_new_objects_in_the_public_schema).

<!-- BEGIN_TF_DOCS -->
## Global versioning rule for Claranet Azure modules

| Module version | Terraform version | OpenTofu version | AzureRM version |
| -------------- | ----------------- | ---------------- | --------------- |
| >= 8.x.x       | **Unverified**    | 1.8.x            | >= 4.0          |
| >= 7.x.x       | 1.3.x             |                  | >= 3.0          |
| >= 6.x.x       | 1.x               |                  | >= 3.0          |
| >= 5.x.x       | 0.15.x            |                  | >= 2.0          |
| >= 4.x.x       | 0.13.x / 0.14.x   |                  | >= 2.0          |
| >= 3.x.x       | 0.12.x            |                  | >= 2.0          |
| >= 2.x.x       | 0.12.x            |                  | < 2.0           |
| <  2.x.x       | 0.11.x            |                  | < 2.0           |

## Contributing

If you want to contribute to this repository, feel free to use our [pre-commit](https://pre-commit.com/) git hook configuration
which will help you automatically update and format some files for you by enforcing our Terraform code module best-practices.

More details are available in the [CONTRIBUTING.md](./CONTRIBUTING.md#pull-request-process) file.

## Usage

This module is optimized to work with the [Claranet terraform-wrapper](https://github.com/claranet/terraform-wrapper) tool
which set some terraform variables in the environment needed by this module.
More details about variables set by the `terraform-wrapper` available in the [documentation](https://github.com/claranet/terraform-wrapper#environment).

⚠️ Since modules version v8.0.0, we do not maintain/check anymore the compatibility with
[Hashicorp Terraform](https://github.com/hashicorp/terraform/). Instead, we recommend to use [OpenTofu](https://github.com/opentofu/opentofu/).

```hcl
module "postgresql_flexible" {
  source  = "claranet/db-postgresql-flexible/azurerm"
  version = "x.x.x"

  client_name    = var.client_name
  location       = module.azure_region.location
  location_short = module.azure_region.location_short
  environment    = var.environment
  stack          = var.stack

  resource_group_name = module.rg.name

  tier               = "GeneralPurpose"
  size               = "D2s_v3"
  storage_mb         = 32768
  postgresql_version = 16

  allowed_cidrs = {
    "1" = "10.0.0.0/24"
    "2" = "12.34.56.78/32"
  }

  backup_retention_days        = 14
  geo_redundant_backup_enabled = true

  administrator_login = "azureadmin"

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

  logs_destinations_ids = [
    module.logs.logs_storage_account_id,
    module.logs.log_analytics_workspace_id
  ]

  extra_tags = {
    foo = "bar"
  }
}

provider "postgresql" {
  host      = module.postgresql_flexible.fqdn
  port      = 5432
  username  = module.postgresql_flexible.administrator_login
  password  = module.postgresql_flexible.administrator_password
  sslmode   = "require"
  superuser = false
}

module "postgresql_users" {
  source  = "claranet/users/postgresql"
  version = "x.x.x"

  for_each = module.postgresql_flexible.databases_names

  administrator_login = module.postgresql_flexible.administrator_login

  database = each.key
}

module "postgresql_configuration" {
  source  = "claranet/database-configuration/postgresql"
  version = "x.x.x"

  for_each = module.postgresql_flexible.databases_names

  administrator_login = module.postgresql_flexible.administrator_login

  database_admin_user = module.postgresql_users[each.key].user
  database            = each.key
  schema_name         = each.key
}
```

## Providers

| Name | Version |
|------|---------|
| azurecaf | ~> 1.2.28 |
| azurerm | ~> 4.0 |
| random | >= 2.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| diagnostics | claranet/diagnostic-settings/azurerm | ~> 8.0.0 |

## Resources

| Name | Type |
|------|------|
| [azurerm_postgresql_flexible_server.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/postgresql_flexible_server) | resource |
| [azurerm_postgresql_flexible_server_configuration.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/postgresql_flexible_server_configuration) | resource |
| [azurerm_postgresql_flexible_server_database.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/postgresql_flexible_server_database) | resource |
| [azurerm_postgresql_flexible_server_firewall_rule.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/postgresql_flexible_server_firewall_rule) | resource |
| [random_password.administrator_password](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [azurecaf_name.postgresql_flexible_dbs](https://registry.terraform.io/providers/claranet/azurecaf/latest/docs/data-sources/name) | data source |
| [azurecaf_name.postgresql_flexible_server](https://registry.terraform.io/providers/claranet/azurecaf/latest/docs/data-sources/name) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| administrator\_login | PostgreSQL administrator login. | `string` | n/a | yes |
| administrator\_password | PostgreSQL administrator password. Strong password definition in the [documentation](https://docs.microsoft.com/en-us/sql/relational-databases/security/strong-passwords?view=sql-server-2017). | `string` | `null` | no |
| allowed\_cidrs | Map of allowed CIDRs. | `map(string)` | n/a | yes |
| authentication | Authentication configurations for the PostgreSQL Flexible server | <pre>object({<br/>    active_directory_auth_enabled = optional(bool)<br/>    password_auth_enabled         = optional(bool)<br/>    tenant_id                     = optional(string)<br/>  })</pre> | `{}` | no |
| auto\_grow\_enabled | Enable auto grow for the PostgreSQL Flexible Server. | `bool` | `false` | no |
| backup\_retention\_days | Backup retention days for the PostgreSQL Flexible server. Value should be between 7 and 35 days. | `number` | `7` | no |
| caf\_naming\_for\_databases\_enabled | Use the Azure CAF naming provider to generate databases name. | `bool` | `false` | no |
| client\_name | Client name/account used in naming. | `string` | n/a | yes |
| configurations | PostgreSQL configurations to enable. | `map(string)` | `{}` | no |
| custom\_name | Custom Server Name identifier. | `string` | `""` | no |
| databases | Map of databases configurations with database name as key and following available configuration option:<br/>   *  (optional) charset: Valid PostgreSQL charset : https://www.postgresql.org/docs/current/multibyte.html#CHARSET-TABLE<br/>   *  (optional) collation: Valid PostgreSQL collation : http://www.postgresql.cn/docs/13/collation.html - be careful about https://docs.microsoft.com/en-us/windows/win32/intl/locale-names?redirectedfrom=MSDN | <pre>map(object({<br/>    charset   = optional(string, "UTF8")<br/>    collation = optional(string, "en_US.utf8")<br/>  }))</pre> | `{}` | no |
| delegated\_subnet\_id | ID of the subnet to create the PostgreSQL Flexible server. Should not have any resource deployed in. | `string` | `null` | no |
| diagnostic\_settings\_custom\_name | Custom name of the diagnostics settings, name will be 'default' if not set. | `string` | `"default"` | no |
| environment | Project environment. | `string` | n/a | yes |
| extra\_tags | Map of custom tags. | `map(string)` | `{}` | no |
| geo\_redundant\_backup\_enabled | Enable Geo Redundant Backup for the PostgreSQL Flexible server. | `bool` | `false` | no |
| location | Azure location. | `string` | n/a | yes |
| location\_short | Short string for Azure location. | `string` | n/a | yes |
| logs\_categories | Log categories to send to destinations. | `list(string)` | `null` | no |
| logs\_destinations\_ids | List of destination resources IDs for logs diagnostic destination.<br/>Can be `Storage Account`, `Log Analytics Workspace` and `Event Hub`. No more than one of each can be set.<br/>If you want to use Azure EventHub as a destination, you must provide a formatted string containing both the EventHub Namespace authorization send ID and the EventHub name (name of the queue to use in the Namespace) separated by the <code>&#124;</code> character. | `list(string)` | n/a | yes |
| logs\_metrics\_categories | Metrics categories to send to destinations. | `list(string)` | `null` | no |
| maintenance\_window | Map of maintenance window configuration. | `map(number)` | `null` | no |
| name\_prefix | Optional prefix for the generated name. | `string` | `""` | no |
| name\_suffix | Optional suffix for the generated name. | `string` | `""` | no |
| postgresql\_version | Version of PostgreSQL Flexible Server. Possible values are in the [documentation](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/postgresql_flexible_server#version). | `number` | `16` | no |
| private\_dns\_zone\_id | ID of the private DNS zone to create the PostgreSQL Flexible server. | `string` | `null` | no |
| public\_network\_access\_enabled | Enable public network access for the PostgreSQL Flexible server. | `bool` | `false` | no |
| resource\_group\_name | Resource group name. | `string` | n/a | yes |
| size | Size for PostgreSQL Flexible server SKU. See [documentation](https://docs.microsoft.com/en-us/azure/postgresql/flexible-server/concepts-compute-storage). | `string` | `"D2ds_v4"` | no |
| stack | Project stack name. | `string` | n/a | yes |
| standby\_zone | Specify availability-zone to enable high-availability and create standby PostgreSQL Flexible Server. `null` to disable high-availability. | `number` | `2` | no |
| storage\_mb | Storage allowed for PostgresSQL Flexible server. See [documentation](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/postgresql_flexible_server#storage_mb). | `number` | `32768` | no |
| tier | Tier for PostgreSQL Flexible server SKU. See [documentation](https://docs.microsoft.com/en-us/azure/postgresql/flexible-server/concepts-compute-storage). Possible values are: `GeneralPurpose`, `Burstable`, `MemoryOptimized`. | `string` | `"GeneralPurpose"` | no |
| zone | Specify availability-zone for PostgreSQL Flexible main server. | `number` | `1` | no |

## Outputs

| Name | Description |
|------|-------------|
| administrator\_login | Administrator login for PostgreSQL Flexible server. |
| administrator\_password | Administrator password for PostgreSQL Flexible server. |
| configurations | The map of all PostgreSQL configurations set. |
| database\_ids | The map of all database resource IDs. |
| databases\_names | Map of databases names. |
| firewall\_rules | Map of PostgreSQL created rules. |
| fqdn | FQDN of the PostgreSQL server. |
| id | ID of the Azure PostgreSQL Flexible server. |
| module\_diagnostics | Diagnostics settings module outputs. |
| name | Name of the Azure PostgreSQL Flexible server. |
| resource | Azure PostgreSQL server resource object. |
| resource\_configuration | Azure PostgreSQL configuration resource object. |
| resource\_database | Azure PostgreSQL database resource object. |
| resource\_firewall\_rule | Azure PostgreSQL server firewall rule resource object. |
| server\_id | PostgreSQL server ID. |
| terraform\_module | Information about this Terraform module |
<!-- END_TF_DOCS -->
## Related documentation

Microsoft Azure documentation: [docs.microsoft.com/fr-fr/azure/postgresql/flexible-server/](https://docs.microsoft.com/fr-fr/azure/postgresql/flexible-server/)
