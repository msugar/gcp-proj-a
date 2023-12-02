resource "google_storage_bucket" "bucket" {
  name     = "${var.project_id}-lz"
  location = var.region
}