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
  description = "Resource group name."
  type        = string
}

variable "tier" {
  description = "Tier for PostgreSQL Flexible server SKU. See [documentation](https://docs.microsoft.com/en-us/azure/postgresql/flexible-server/concepts-compute-storage). Possible values are: `GeneralPurpose`, `Burstable`, `MemoryOptimized`."
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

variable "auto_grow_enabled" {
  description = "Enable auto grow for the PostgreSQL Flexible Server."
  type        = bool
  default     = false
}

variable "postgresql_version" {
  description = "Version of PostgreSQL Flexible Server. Possible values are in the [documentation](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/postgresql_flexible_server#version)."
  type        = number
  default     = 16
}

variable "zone" {
  description = "Specify availability-zone for PostgreSQL Flexible main server."
  type        = number
  default     = 1
}

variable "standby_zone" {
  description = "Specify availability-zone to enable high-availability and create standby PostgreSQL Flexible Server. `null` to disable high-availability."
  type        = number
  default     = 2
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
  type        = map(number)
  default     = null
}

variable "private_dns_zone_id" {
  description = "ID of the private DNS zone to create the PostgreSQL Flexible server."
  type        = string
  default     = null
}

variable "delegated_subnet_id" {
  description = "ID of the subnet to create the PostgreSQL Flexible server. Should not have any resource deployed in."
  type        = string
  default     = null
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

variable "configurations" {
  description = "PostgreSQL configurations to enable."
  type        = map(string)
  default     = {}
}

variable "allowed_cidrs" {
  description = "Map of allowed CIDRs."
  type        = map(string)
}

variable "public_network_access_enabled" {
  description = "Enable public network access for the PostgreSQL Flexible server."
  type        = bool
  default     = false
}

variable "authentication" {
  description = "Authentication configurations for the PostgreSQL Flexible server"
  type = object({
    active_directory_auth_enabled = optional(bool)
    password_auth_enabled         = optional(bool)
    tenant_id                     = optional(string)
  })
  default = {}
}
