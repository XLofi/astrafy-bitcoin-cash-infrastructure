resource "google_service_account_key" "dbt_ci" {
  service_account_id = google_service_account.dbt_ci.name
}
