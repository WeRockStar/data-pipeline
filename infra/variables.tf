variable "project_id" {
  description = "GCP Project ID"
  type        = string
  default     = "learn-airbyte-425016"
}

variable "cluster_name" {
  description = "GKE Cluster Name"
  type        = string
  default     = "my-gke-cluster"
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