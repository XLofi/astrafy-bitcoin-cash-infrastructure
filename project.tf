resource "google_project" "bitcoin_cash" {
  project_id      = var.project_id
  name            = var.project_name
  org_id          = var.org_id
  billing_account = var.billing_account_id

  deletion_policy = "DELETE"
}

resource "google_project_service" "bigquery" {
  project = google_project.bitcoin_cash.project_id
  service = "bigquery.googleapis.com"

  disable_on_destroy = false
}

resource "google_project_service" "iam" {
  project = google_project.bitcoin_cash.project_id
  service = "iam.googleapis.com"

  disable_on_destroy = false
}
