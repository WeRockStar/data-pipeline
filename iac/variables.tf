variable "project_id" {
  description = "GCP Project ID"
  type        = string
  default     = "learn-airbyte-425016"
}

variable "project_name" {
  description = "Name of Porject"
  type        = string
  default     = "data-pipeline"
}

variable "cloudflare_api_token" {
  type      = string
  sensitive = true
}

variable "cluster_name" {
  description = "GKE Cluster Name"
  type        = string
  default     = "data-pipeline-cluster"
}

variable "region" {
  type    = string
  default = "asia-southeast1"
}
