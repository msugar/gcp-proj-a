output "target_project_id" {
  value = google_project.target.project_id
}

output "target_tf_state_bucket" {
  value = google_storage_bucket.target_tf_state.url
}