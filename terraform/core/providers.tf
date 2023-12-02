terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "5.7.0"
    }
  }

  backend "gcs" {
    # Run `make np` or `make pr` to set the proper bucket and prefix for each environment
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
}

