variable "env" {
    type = string
    nullable = false
}

variable "project_prefix" {
    type = string
    nullable = false
}

variable "gcp_services_list" {
 description = "The list of GCP APIs necessary for the project."
 type       = list(string)
 default    = ["storage.googleapis.com", "bigquery.googleapis.com"]
}
