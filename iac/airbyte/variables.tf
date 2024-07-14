variable "cluster_name" {
  description = "GKE Cluster Name"
  type        = string
}

variable "location" {
  type    = string
}

variable "cluster_endpoint" {
  type        = string
  description = "GKE Cluster Endpoint"
  sensitive   = true
}

variable "cluster_ca_certificate" {
  type        = string
  description = "GKE Cluster CA Certificate"
  sensitive   = true
}
