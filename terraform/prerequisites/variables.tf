variable "env" {
  description = "The environment to deploy the target project to."
  type        = string
  nullable    = false

  validation {
    condition     = can(regex("^(np|pr)$", var.env))
    error_message = "The environment must be one of np or pr."
  }
}

variable "region" {
  description = "The region to deploy the target project to."
  type        = string
  nullable    = false

  validation {
    condition     = can(regex("^(northamerica-northeast1|northamerica-northeast2)$", var.region))
    error_message = "The region must be one of northamerica-northeast1 or northamerica-northeast2."
  }
}

variable "project_prefix" {
  description = "The prefix to use for the target project's name."
  type        = string
  nullable    = false
  default     = "proj-a"

  validation {
    condition     = can(regex("^[a-z][a-z0-9-]{1,28}[a-z0-9]$", var.project_prefix))
    error_message = "The project prefix must be lowercase, start with a letter, end with a letter or number, and be between 3 and 30 characters long."
  }
}

variable "gcp_services_list" {
  description = "The list of GCP APIs necessary for the target project."
  type        = list(string)
  default = [
    "compute.googleapis.com",
    "storage.googleapis.com",
    "bigquery.googleapis.com"
  ]
}

variable "gcs_location" {
  description = "The location of the GCS bucket that will store the tfstate files for the target project."
  type        = string
  default     = "NORTHAMERICA-NORTHEAST1"

  validation {
    condition     = can(regex("^(NORTHAMERICA-NORTHEAST1|NORTHAMERICA-NORTHEAST2)$", var.gcs_location))
    error_message = "The GCS location must be one of NORTHAMERICA-NORTHEAST1 or NORTHAMERICA-NORTHEAST2."
  }
}
