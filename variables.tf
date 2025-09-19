variable "location" {
  description = "Azure location."
  type        = string
}

variable "location_short" {
  description = "Short string for Azure location."
  type        = string
}

variable "client_name" {
  description = "Client name/account used in naming."
  type        = string
}

variable "environment" {
  description = "Project environment."
  type        = string
}

variable "stack" {
  description = "Project stack name."
  type        = string
}

variable "resource_group_name" {
  description = "Resource Group name."
  type        = string
}

variable "administrator_login" {
  description = "PostgreSQL administrator login."
  type        = string
}

variable "administrator_password" {
  description = "PostgreSQL administrator password. Strong password definition in the [documentation](https://docs.microsoft.com/en-us/sql/relational-databases/security/strong-passwords?view=sql-server-2017)."
  type        = string
  default     = null
}

variable "tier" {
  description = "Tier for PostgreSQL Flexible server SKU. See [documentation](https://docs.microsoft.com/en-us/azure/postgresql/flexible-server/concepts-compute-storage). Possible values are: `GeneralPurpose`, `Burstable` and `MemoryOptimized`."
  type        = string
  default     = "GeneralPurpose"
}

variable "size" {
  description = "Size for PostgreSQL Flexible server SKU. See [documentation](https://docs.microsoft.com/en-us/azure/postgresql/flexible-server/concepts-compute-storage)."
  type        = string
  default     = "D2ds_v4"
}

variable "storage_mb" {
  description = "Storage allowed for PostgresSQL Flexible server. See [documentation](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/postgresql_flexible_server#storage_mb)."
  type        = number
  default     = 32768
}

variable "storage_tier" {
  description = "The name of storage performance tier for IOPS of the PostgreSQL Flexible Server. Possible values are `P4`, `P6`, `P10`, `P15`, `P20`, `P30`, `P40`, `P50`, `P60`, `P70` or `P80`."
  type        = string
  default     = null

  validation {
    condition     = var.storage_tier == null || contains(["P4", "P6", "P10", "P15", "P20", "P30", "P40", "P50", "P60", "P70", "P80"], var.storage_tier)
    error_message = "The `storage_tier` value must be one of `P4`, `P6`, `P10`, `P15`, `P20`, `P30`, `P40`, `P50`, `P60`, `P70`, `P80`, or null."
  }
}

variable "auto_grow_enabled" {
  description = "Enable auto grow for the PostgreSQL Flexible server."
  type        = bool
  default     = false
}

variable "postgresql_version" {
  description = "Version of PostgreSQL Flexible server. Possible values are in the [documentation](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/postgresql_flexible_server#version)."
  type        = number
  default     = 16
}

variable "delegated_subnet" {
  description = "ID of the Subnet to create the PostgreSQL Flexible server. No resources to be deployed in it."
  type = object({
    id = string
  })
  default = null
}

variable "private_dns_zone" {
  description = "ID of the Private DNS Zone to create the PostgreSQL Flexible server."
  type = object({
    id = string
  })
  default = null
}

variable "public_network_access_enabled" {
  description = "Enable public network access for the PostgreSQL Flexible server."
  type        = bool
  default     = false
}

variable "backup_retention_days" {
  description = "Backup retention days for the PostgreSQL Flexible server. Value should be between 7 and 35 days."
  type        = number
  default     = 7
}

variable "geo_redundant_backup_enabled" {
  description = "Enable Geo Redundant Backup for the PostgreSQL Flexible server."
  type        = bool
  default     = false
}

variable "maintenance_window" {
  description = "Map of maintenance window configuration."
  type = object({
    day_of_week  = optional(number, 0)
    start_hour   = optional(number, 0)
    start_minute = optional(number, 0)
  })
  default = null
}

variable "authentication" {
  description = "Authentication configuration for the PostgreSQL Flexible server."
  type = object({
    active_directory_auth_enabled = optional(bool)
    password_auth_enabled         = optional(bool)
    tenant_id                     = optional(string)
  })
  default = null
}

variable "zone" {
  description = "Specify the Availability Zone for the PostgreSQL Flexible server."
  type        = number
  default     = 1
}

variable "databases" {
  description = <<EOF
  Map of databases configurations with database name as key and following available configuration option:
   *  (optional) charset: Valid PostgreSQL charset : https://www.postgresql.org/docs/current/multibyte.html#CHARSET-TABLE
   *  (optional) collation: Valid PostgreSQL collation : http://www.postgresql.cn/docs/13/collation.html - be careful about https://docs.microsoft.com/en-us/windows/win32/intl/locale-names?redirectedfrom=MSDN
  EOF
  type = map(object({
    charset   = optional(string, "UTF8")
    collation = optional(string, "en_US.utf8")
  }))
  default = {}
}

variable "allowed_cidrs" {
  description = "Map of allowed CIDRs."
  type        = map(string)
}

variable "allowed_azure_services" {
  description = "Whether to allow Azure services to access the PostgreSQL Flexible server."
  type        = bool
  default     = false
  nullable    = false
}

variable "configurations" {
  description = "PostgreSQL configuration values to set on the PostgreSQL Flexible server."
  type        = map(string)
  default     = {}
}

variable "recommended_configurations_enabled" {
  description = "Whether to enable recommended configurations for the PostgreSQL Flexible server."
  type        = bool
  default     = true
  nullable    = false
}

variable "high_availability" {
  description = "Object of high availability configuration. See [documentation](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/postgresql_flexible_server#mode-1)."
  type = object({
    mode                      = optional(string, "ZoneRedundant")
    standby_availability_zone = optional(number, 2)
  })
  default = {}
}

variable "backup_policy_id" {
  description = "Backup Vault policy ID to use for the PostgreSQL Flexible server."
  type        = string
  default     = null
}

variable "backup_role_assignment_enabled" {
  description = "Whether to create the role assignments for the Backup Vault."
  type        = bool
  default     = true
}
