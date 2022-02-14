# --------
# r-logs.tf
variable "enable_logs_to_storage" {
  description = "Boolean flag to specify whether the logs should be sent to the Storage Account."
  type        = bool
  default     = false
}

variable "enable_logs_to_log_analytics" {
  description = "Boolean flag to specify whether the logs should be sent to Log Analytics."
  type        = bool
  default     = false
}

variable "logs_storage_account_id" {
  description = "Storage Account id for logs."
  type        = string
  default     = ""
}

variable "logs_log_analytics_workspace_id" {
  description = "Log Analytics Workspace id for logs."
  type        = string
  default     = ""
}