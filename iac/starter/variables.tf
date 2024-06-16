variable "cluster_name" {
  description = "GKE Cluster Name"
  type        = string
  default     = "data-pipeline-cluster"
}

variable "region" {
  type    = string
  default = "asia-southeast1"
}

variable "project_id" {
  description = "GCP Project ID"
  type        = string
}

variable "project_name" {
  description = "Name of Porject"
  type        = string
  default     = "data-pipeline"
}
