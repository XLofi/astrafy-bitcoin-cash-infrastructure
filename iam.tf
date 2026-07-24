resource "google_project_iam_member" "dbt_job_user" {
  project = google_project.bitcoin_cash.project_id
  role    = "roles/bigquery.jobUser"
  member  = "serviceAccount:${google_service_account.dbt_ci.email}"
}

resource "google_bigquery_dataset_iam_member" "staging_editor" {
  project    = google_project.bitcoin_cash.project_id
  dataset_id = google_bigquery_dataset.staging.dataset_id
  role       = "roles/bigquery.dataEditor"
  member     = "serviceAccount:${google_service_account.dbt_ci.email}"
}

resource "google_bigquery_dataset_iam_member" "data_mart_editor" {
  project    = google_project.bitcoin_cash.project_id
  dataset_id = google_bigquery_dataset.data_mart.dataset_id
  role       = "roles/bigquery.dataEditor"
  member     = "serviceAccount:${google_service_account.dbt_ci.email}"
}
