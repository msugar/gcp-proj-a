terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "5.7.0"
    }
  }

  backend "gcs" {
    bucket = "tf-state-proj-a-np-836412"
    prefix = "terraform/np"
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
}

