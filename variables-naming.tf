variable "name_prefix" {
  description = "Optional prefix for PostgreSQL server name."
  type        = string
  default     = ""
}

variable "custom_server_name" {
  type        = string
  description = "Custom Server Name identifier."
  default     = ""
}