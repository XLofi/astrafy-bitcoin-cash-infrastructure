output "project_id" {
  value = google_project.bitcoin_cash.project_id
}

output "staging_dataset" {
  value = google_bigquery_dataset.staging.dataset_id
}

output "data_mart_dataset" {
  value = google_bigquery_dataset.data_mart.dataset_id
}

output "dbt_service_account_email" {
  value = google_service_account.dbt_ci.email
}

output "dbt_service_account_key" {
  description = "JSON key used by dbt CI."
  value       = base64decode(google_service_account_key.dbt_ci.private_key)
  sensitive   = true
}
