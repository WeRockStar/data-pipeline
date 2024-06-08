terraform {
  required_version = ">= 1.8.0"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "5.31.1"
    }
  }

  backend "gcs" {
    bucket = "data-pipeline-network-tfstate-425016"
  }

}

provider "google" {
  project = var.project_id
  region  = "asia-southeast1"

  default_labels = {
    project = var.project_name
  }
}
