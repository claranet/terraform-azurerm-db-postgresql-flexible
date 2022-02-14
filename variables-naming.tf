# Generic naming variables
variable "name_prefix" {
  description = "Optional prefix for the generated name."
  type        = string
  default     = ""
}

variable "name_suffix" {
  description = "Optional suffix for the generated name."
  type        = string
  default     = ""
}

variable "use_caf_naming" {
  description = "Use the Azure CAF naming provider to generate default resource name. `custom_server_name` override this if set. Legacy default name is used if this is set to `false`."
  type        = bool
  default     = true
}

# Custom naming override
variable "custom_server_name" {
  type        = string
  description = "Custom Server Name identifier."
  default     = ""
}

variable "use_caf_naming_for_databases" {
  description = "Use the Azure CAF naming provider to generate databases name."
  type        = bool
  default     = false
}
