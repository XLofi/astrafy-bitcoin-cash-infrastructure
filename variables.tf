variable "project_id" {
  description = "Globally unique Google Cloud project ID."
  type        = string
}

variable "project_name" {
  description = "Google Cloud project display name."
  type        = string
  default     = "Bitcoin Cash Analytics"
}

variable "billing_account_id" {
  description = "Google Cloud billing account ID."
  type        = string
  sensitive   = true
}

variable "org_id" {
  description = "Google Cloud organization ID."
  type        = string
}

variable "region" {
  description = "Default Google Cloud region."
  type        = string
  default     = "europe-west9"
}

variable "bigquery_location" {
  description = "BigQuery dataset location."
  type        = string
  default     = "europe-west9"
}
