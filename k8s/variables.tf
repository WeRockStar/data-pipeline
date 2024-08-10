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

variable "region" {
  type    = string
  default = "asia-southeast1"
}

variable "zone_id" {
  type        = string
  description = "Cloudflare Zone ID"
}

variable "cluster_name" {
  description = "GKE Cluster Name"
  type        = string
  default     = "data-pipeline-cluster"
}

variable "location" {
  type    = string
  default = "asia-southeast1-a"
}

variable "cluster_endpoint" {
  type        = string
  description = "GKE Cluster Endpoint"
  sensitive   = true
}
