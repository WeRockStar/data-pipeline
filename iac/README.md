# Terraform

## Overview

This repository contains the Terraform code to deploy the infrastructure for Data Pipleline project.

## Prerequisites

- Terraform
- GCP account
- gcloud CLI

## Setup

- Clone the repository
- Create a new project in GCP
- Login to GCP account using `gcloud auth login`
- Set the project using `gcloud config set project <project-id>`
- Change project id in `variables.tf` file
- Plan and apply the Terraform code using `terraform apply` and `terraform apply`
- Destroy the infrastructure using `terraform destroy`

### Provisioning

Goal is to provision the following resources and organize them in modules:

- [x] Network - VPC, Subnet. Apply the `network` module first.
- [ ] GKE
  - [x] Service Account
  - [x] Node Pool
  - [x] Bastion
  - [ ] Install `Airflow`, `Airbyte`, and other tools
- [ ] Cloud SQL (Postgres)
- [ ] Cloud Storage (Bucket)
- [ ] BigQuery Dataset

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.9.0 |
| <a name="requirement_cloudflare"></a> [cloudflare](#requirement\_cloudflare) | 4.34.0 |
| <a name="requirement_google"></a> [google](#requirement\_google) | 5.37.0 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | ~> 2.14 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | 2.29.0 |
| <a name="requirement_template"></a> [template](#requirement\_template) | 2.2.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_airbyte"></a> [airbyte](#module\_airbyte) | ./airbyte | n/a |
| <a name="module_airflow"></a> [airflow](#module\_airflow) | ./airflow | n/a |
| <a name="module_cloudflare"></a> [cloudflare](#module\_cloudflare) | ./cloudflare | n/a |
| <a name="module_gke"></a> [gke](#module\_gke) | ./gke | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cloudflare_api_token"></a> [cloudflare\_api\_token](#input\_cloudflare\_api\_token) | n/a | `string` | n/a | yes |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | GKE Cluster Name | `string` | `"data-pipeline-cluster"` | no |
| <a name="input_location"></a> [location](#input\_location) | n/a | `string` | `"asia-southeast1-a"` | no |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | GCP Project ID | `string` | `"learn-airbyte-425016"` | no |
| <a name="input_project_name"></a> [project\_name](#input\_project\_name) | Name of Porject | `string` | `"data-pipeline"` | no |
| <a name="input_region"></a> [region](#input\_region) | n/a | `string` | `"asia-southeast1"` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
