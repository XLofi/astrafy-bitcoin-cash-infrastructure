resource "google_service_account" "dbt_ci" {
  project      = google_project.bitcoin_cash.project_id
  account_id   = "dbt-ci"
  display_name = "dbt CI service account"

  depends_on = [
    google_project_service.iam
  ]
}
