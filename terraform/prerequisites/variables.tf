variable "env" {
  description = "The environment to deploy the Core project to."
  type        = string
  nullable    = false

  validation {
    condition     = can(regex("^(dev|stg|prd|np|pr)$", var.env))
    error_message = "The environment must be one of dev, stg, or prd. Or, if you're using the non-prod or prod environments, use np or pr, respectively."
  }
}

variable "project_prefix" {
  description = "The prefix to use for the Core project name."
  type        = string
  nullable    = false
  default     = "proj-a"

  validation {
    condition     = can(regex("^[a-z][a-z0-9-]{1,28}[a-z0-9]$", var.project_prefix))
    error_message = "The project prefix must be lowercase, start with a letter, end with a letter or number, and be between 3 and 30 characters long."
  }
}

variable "gcp_services_list" {
  description = "The list of GCP APIs necessary for the Core project."
  type        = list(string)
  default = [
    "compute.googleapis.com",
    "storage.googleapis.com",
    "bigquery.googleapis.com"
  ]
}

variable "gcs_location" {
  description = "The location of the GCS bucket that will store the tfstate file for the Core project."
  type        = string
  default     = "NORTHAMERICA-NORTHEAST1"

  validation {
    condition     = can(regex("^(NORTHAMERICA-NORTHEAST1|NORTHAMERICA-NORTHEAST2)$", var.gcs_location))
    error_message = "The GCS location must be one of NORTHAMERICA-NORTHEAST1 or NORTHAMERICA-NORTHEAST2."
  }
}
