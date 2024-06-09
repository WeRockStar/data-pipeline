terraform {
  required_version = ">= 1.8.0"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "5.31.1"
    }
    template = {
      source  = "hashicorp/template"
      version = "2.2.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.13"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.29.0"
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "4.34.0"
    }
  }

  backend "gcs" {
    bucket = "data-pipeline-tfstate-425016"
  }

}

provider "google" {
  project = var.project_id
  region  = "asia-southeast1"

  default_labels = {
    project = var.project_name
  }
}
