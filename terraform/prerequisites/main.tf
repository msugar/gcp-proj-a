terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "5.7.0"
    }

    random = {
      source  = "hashicorp/random"
      version = "3.5.1"
    }

    time = {
      source  = "hashicorp/time"
      version = "0.9.2"
    }
  }
}

provider "google" {
  region = "northamerica-northeast1"
}

resource "random_integer" "random_project_id" {
  min = 10000
  max = 99999

  keepers = {
    project_name = "${var.project_prefix}-${var.env}"
  }
}

resource "google_project" "core" {
  name       = "${var.project_prefix}-${var.env}"
  project_id = "${var.project_prefix}-${var.env}-${random_integer.random_project_id.result}"

  auto_create_network = false
}

resource "time_sleep" "wait_30_seconds" {
  depends_on = [google_project.core]

  create_duration = "30s"
}

resource "google_project_service" "services" {
  for_each   = toset(var.gcp_services_list)
  project    = google_project.core.project_id
  service    = each.value
  depends_on = [time_sleep.wait_30_seconds]
}

resource "google_storage_bucket" "tf-state" {
  name     = "tf-state-${google_project.core.project_id}"
  location = "NORTHAMERICA-NORTHEAST1"

  public_access_prevention = "enforced"
}

output "project_id" {
  value = google_project.core.project_id
}
