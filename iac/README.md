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

### Provisioning

- [ ] GKE
  - [x] Service Account
  - [x] Node Pool
  - [ ] Bastion
  - [ ] Network
  - [ ] Install Airflow, Airbyte, and other tools
- [ ] Cloud SQL (Postgres)
- [ ] Cloud Storage (Bucket)
- [ ] BigQuery Dataset
