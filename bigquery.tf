resource "google_bigquery_dataset" "staging" {
  project    = google_project.bitcoin_cash.project_id
  dataset_id = "staging"
  location   = var.bigquery_location

  description                = "Staging tables for Bitcoin Cash analytics."
  delete_contents_on_destroy = true

  depends_on = [
    google_project_service.bigquery
  ]
}

resource "google_bigquery_dataset" "data_mart" {
  project    = google_project.bitcoin_cash.project_id
  dataset_id = "data_mart"
  location   = var.bigquery_location

  description                = "Data mart tables for Bitcoin Cash analytics."
  delete_contents_on_destroy = true

  depends_on = [
    google_project_service.bigquery
  ]
}
