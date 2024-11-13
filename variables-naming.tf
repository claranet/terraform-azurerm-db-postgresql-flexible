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

# Custom naming override
variable "custom_name" {
  type        = string
  description = "Custom Server Name identifier."
  default     = ""
}

variable "caf_naming_for_databases_enabled" {
  description = "Use the Azure CAF naming provider to generate databases name."
  type        = bool
  default     = false
}
