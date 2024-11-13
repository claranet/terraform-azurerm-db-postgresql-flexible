variable "azure_region" {
  description = "Azure region to use."
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

variable "vnet_cidr" {
  description = "CIDR for the VNet."
  type        = string
}

variable "subnet_cidr" {
  description = "CIDR for the subnet."
  type        = string
}

variable "administrator_login" {
  description = "Administrator login for PostgreSQL server."
  type        = string
}

variable "administrator_password" {
  description = "Administrator password for PostgreSQL server."
  type        = string
}
