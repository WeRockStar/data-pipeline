terraform {
  required_version = ">= 1.9.0"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "5.40.0"
    }
    template = {
      source  = "hashicorp/template"
      version = "2.2.0"
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "4.37.0"
    }
    null = {
      source  = "hashicorp/null"
      version = "3.2.2"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.31.0"
    }
  }

  backend "gcs" {
    bucket = "data-pipeline-tf-state-425016"
    prefix = "cloudflare-dns"
  }

}

provider "google" {
  project = var.project_id
  region  = var.region

  default_labels = {
    project = var.project_name
  }
}
