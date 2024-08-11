# Terraform

## Overview

This repository contains the Terraform code to deploy the infrastructure for Data Pipleline project.

## Prerequisites

- [Terraform](https://learn.hashicorp.com/tutorials/terraform/install-cli)
- GCP Account
  - GCP Project
- `gcloud` - Google Cloud CLI
- `kubectl` - Kubernetes CLI

## Setup

- Create a new project in GCP
- Login to GCP account using `gcloud auth login`
- Set the project using `gcloud config set project <project-id>`
- Change project id in `variables.tf` file
- Initialize the Terraform code using `terraform init`
- Plan and apply the Terraform code using `terraform plan` and `terraform apply`
- Destroy the infrastructure using `terraform destroy`

### Provisioning

> I use remote backend for storing Terraform state in Google Cloud Storage. But at the first you need to use local backend to store and then migrate to remote backend.

Goal is to provision the following resources and organize them in modules:

Here is the list of resources to be provisioned:

- [x] Network - VPC, Subnet. Apply the `network` module first.
- [x] GKE
  - [x] Service Account
  - [x] Node Pool
- [ ] Cloud SQL (Postgres)
  - [ ] Postgres for Airflow
  - [ ] And one for acting as a Data Source/Destination
- [x] Cloud Storage (Bucket)
  - [x] Terraform State
- [ ] BigQuery Dataset - Data Warehouse

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.9.0 |
| <a name="requirement_google"></a> [google](#requirement\_google) | 5.40.0 |
| <a name="requirement_template"></a> [template](#requirement\_template) | 2.2.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_data_storage"></a> [data\_storage](#module\_data\_storage) | ./modules/data-storage | n/a |
| <a name="module_gke"></a> [gke](#module\_gke) | ./modules/gke | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | GKE Cluster Name | `string` | `"data-pipeline-cluster"` | no |
| <a name="input_location"></a> [location](#input\_location) | n/a | `string` | `"asia-southeast1-a"` | no |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | GCP Project ID | `string` | `"learn-airbyte-425016"` | no |
| <a name="input_project_name"></a> [project\_name](#input\_project\_name) | Name of Porject | `string` | `"data-pipeline"` | no |
| <a name="input_region"></a> [region](#input\_region) | n/a | `string` | `"asia-southeast1"` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
