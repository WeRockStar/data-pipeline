terraform {
  required_version = ">= 1.8.0"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "5.31.1"
    }
  }

  backend "gcs" {
    bucket = "data-pipeline-tfstate-425016"
  }

}

provider "google" {
  project = var.project_id
  region  = "asia-southeast1"
}