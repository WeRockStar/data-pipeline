variable "project_id" {
  description = "GCP Project ID"
  type        = string
  default     = "learn-airbyte-425016"
}

variable "cluster_name" {
  description = "GKE Cluster Name"
  type        = string
  default     = "data-pipeline-cluster"
}

variable "sa-roles" {
  type = list(string)
  default = [
    "roles/logging.admin",
    "roles/monitoring.admin",
    "roles/cloudtrace.admin",
    "roles/servicemanagement.serviceController",
    "roles/artifactregistry.reader"
  ]
}

variable "location" {
  type    = string
  default = "asia-southeast1-a"
}

variable "node_count" {
  description = "Number of GKE nodes"
  type        = number
  default     = 2
}

variable "services" {
  description = "List of GCP services to enable"
  type        = list(string)
  default     = ["compute.googleapis.com", "iam.googleapis.com", "container.googleapis.com"]

}
