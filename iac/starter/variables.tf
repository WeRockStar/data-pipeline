variable "cluster_name" {
  description = "GKE Cluster Name"
  type        = string
  default     = "data-pipeline-cluster"
}

variable "region" {
  type    = string
  default = "asia-southeast1"
}

variable "ip_range" {
  description = "The CIDR range for the VPC."
  type        = string
  default     = "10.0.96.0/22"
}

variable "secondary_ip_range" {
  // See https://cloud.google.com/kubernetes-engine/docs/how-to/alias-ips
  description = "The CIDR from which to allocate pod IPs for IP Aliasing."
  type        = string
  default     = "10.0.92.0/22"
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
