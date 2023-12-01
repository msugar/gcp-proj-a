terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "5.7.0"
    }
  }

  backend "gcs" {
    bucket = "tf-state-${var.project_id}"
    prefix = "core"
  }
}

provider "google" {
  project = var.project_id
  region  = "northamerica-northeast1"
}

