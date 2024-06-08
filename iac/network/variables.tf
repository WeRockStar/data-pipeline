variable "cluster_name" {
  description = "GKE Cluster Name"
  type        = string
}

variable "region" {
  type    = string
  default = "asia-southeast1"
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
  default     = "learn-airbyte-425016"
}

variable "project_name" {
  description = "Name of Porject"
  type        = string
  default     = "data-pipeline"
}
