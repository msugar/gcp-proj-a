output "core_project_id" {
  value = google_project.core.project_id
}

output "core_tf_state_bucket" {
  value = google_storage_bucket.core_tf_state.url
}