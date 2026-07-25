# Bitcoin Cash Analytics — Terraform Infrastructure

This repository contains the Terraform infrastructure for the Astrafy Data Engineer take-home challenge.

It provisions the Google Cloud resources required by the Bitcoin Cash dbt analytics project.

## Architecture

```text
Terraform
   ↓
Google Cloud project
   ↓
BigQuery datasets
   ├── staging
   └── data_mart
   ↓
dbt CI service account
   ↓
BigQuery IAM permissions
   ↓
GitHub Actions authentication
```

The dbt models and GitHub Actions workflow are maintained in a separate repository.

## Provisioned resources

The Terraform configuration provisions:

- A Google Cloud project configuration
- Required Google Cloud APIs
- A BigQuery staging dataset
- A BigQuery data-mart dataset
- A service account for dbt continuous integration
- BigQuery permissions for the CI service account
- A service-account key used by GitHub Actions
- Terraform outputs for the project, datasets, and service account

Google Cloud project:

```text
astrafy-bch-xlofi-2026
```

BigQuery datasets:

```text
staging
data_mart
```

## Project structure

```text
.
├── .gitignore
├── .terraform.lock.hcl
├── README.md
├── bigquery.tf
├── iam.tf
├── outputs.tf
├── project.tf
├── providers.tf
├── service_account.tf
├── service_account_key.tf
├── terraform.tfvars.example
├── variables.tf
└── versions.tf
```

The exact file structure may vary slightly as the project evolves.

## Prerequisites

- Terraform
- Google Cloud CLI
- A Google Cloud account
- Permission to manage the target Google Cloud project
- A billing account linked to the project, when required

Authenticate locally:

```bash
gcloud auth application-default login
```

Set the active project:

```bash
gcloud config set project astrafy-bch-xlofi-2026
```

Set the Application Default Credentials quota project:

```bash
gcloud auth application-default set-quota-project astrafy-bch-xlofi-2026
```

## Configuration

Create a local `terraform.tfvars` file:

```hcl
project_id         = "astrafy-bch-xlofi-2026"
project_name       = "Bitcoin Cash Analytics"
billing_account_id = "XXXXXX-XXXXXX-XXXXXX"
org_id             = null
region             = "europe-west9"
bigquery_location  = "US"
```

Depending on the variables defined by the project, additional values may be required.

The `terraform.tfvars` file must not be committed when it contains environment-specific or sensitive values.

## Initialize Terraform

```bash
terraform init
```

Format the configuration:

```bash
terraform fmt -recursive
```

Validate the configuration:

```bash
terraform validate
```

## Plan the infrastructure

```bash
terraform plan
```

To save the plan locally:

```bash
terraform plan -out=tfplan
```

Plan files must not be committed.

## Apply the infrastructure

```bash
terraform apply
```

Or apply a previously saved plan:

```bash
terraform apply tfplan
```

Terraform will create or update the Google Cloud resources declared in the configuration.

## Verify the deployment

List the BigQuery datasets:

```bash
bq ls --project_id=astrafy-bch-xlofi-2026
```

Expected datasets:

```text
staging
data_mart
```

Verify Terraform state and configuration consistency:

```bash
terraform plan
```

A fully synchronized deployment should return:

```text
No changes. Your infrastructure matches the configuration.
```

## Terraform outputs

The configuration exposes outputs such as:

```text
project_id
staging_dataset
data_mart_dataset
dbt_service_account_email
dbt_service_account_key
```

Display non-sensitive outputs:

```bash
terraform output
```

Display the CI service-account email:

```bash
terraform output -raw dbt_service_account_email
```

Retrieve the sensitive service-account key only when configuring GitHub Actions:

```bash
terraform output -raw dbt_service_account_key
```

Do not print or store this key unnecessarily.

## GitHub Actions integration

The dbt repository requires the following GitHub secrets:

```text
GCP_PROJECT_ID
GCP_SERVICE_ACCOUNT_KEY
```

Set `GCP_PROJECT_ID` to:

```text
astrafy-bch-xlofi-2026
```

Set `GCP_SERVICE_ACCOUNT_KEY` from the sensitive Terraform output:

```bash
terraform output -raw dbt_service_account_key
```

The GitHub Actions workflow uses these values to authenticate with Google Cloud and run dbt on pull requests.

## IAM permissions

The dbt CI service account receives the permissions required to:

- Run BigQuery jobs
- Read the public Bitcoin Cash source dataset
- Create and update objects in the target BigQuery datasets
- Execute dbt models and tests in CI

The permissions are intentionally scoped to the needs of the challenge.

In a production environment, permissions should be reviewed regularly and restricted according to the principle of least privilege.

## State management

Terraform state may contain sensitive values, including the generated service-account private key.

The following files must never be committed:

```text
terraform.tfstate
terraform.tfstate.*
terraform.tfvars
*.tfplan
tfplan
```

This challenge uses local Terraform state.

For a production implementation, the state should be stored in a secured remote backend with:

- Encryption
- Access controls
- State locking
- Versioning
- Audit logging

## Security considerations

The service-account key is marked as sensitive in Terraform outputs, but it is still stored in Terraform state.

This means:

- The state file must be protected
- The key must never be committed
- The key should be rotated if exposed
- Access to the state should be restricted
- Long-lived credentials should be avoided in production

For a production GitHub Actions setup, Workload Identity Federation is preferred over a long-lived service-account key.

Workload Identity Federation allows GitHub Actions to authenticate without storing a permanent Google Cloud private key.

## Cleanup

To destroy all Terraform-managed resources:

```bash
terraform destroy
```

Review the destruction plan carefully before confirming.

Destroying the infrastructure may delete datasets and other resources managed by Terraform.

## Validation

The infrastructure was validated with:

```bash
terraform fmt -check -recursive
terraform validate
terraform plan
```

The final Terraform plan should report no drift after deployment.

## Related repository

The dbt analytics project is maintained separately:

```text
https://github.com/XLofi/astrafy-bitcoin-cash-dbt
```

## Author

Julio Germade  
Astrafy Data Engineer Take-Home Challenge
