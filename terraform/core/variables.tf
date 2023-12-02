variable "env" {
  description = "The environment to deploy the project to."
  type        = string
  nullable    = false

  validation {
    condition     = can(regex("^(np|pr)$", var.env))
    error_message = "The environment must be one of np or pr."
  }
}
variable "project_id" {
  description = "Google Cloud project ID."
  type        = string
  nullable    = false
}

variable "region" {
  description = "Google Cloud region."
  type        = string
  nullable    = false
  default     = "northamerica-northeast1"
}
