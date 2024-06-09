variable "project_id" {
  description = "GCP Project ID"
  type        = string
}

variable "project_name" {
  description = "Name of Porject"
  type        = string
}

variable "cluster_name" {
  description = "GKE Cluster Name"
  type        = string
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

variable "region" {
  type = string
}

variable "location" {
  type    = string
  default = "asia-southeast1-a"
}

variable "zone_c" {
  type    = string
  default = "asia-southeast1-c"
}

variable "node_count" {
  description = "Number of GKE nodes"
  type        = number
}

variable "services" {
  description = "List of GCP services to enable"
  type        = list(string)
  default     = ["compute.googleapis.com", "iam.googleapis.com", "container.googleapis.com"]

}

variable "bastion_machine_type" {
  description = "The instance size to use for your bastion instance."
  type        = string
  default     = "g1-small"
}

variable "bastion_hostname" {
  type    = string
  default = "gke-bastion"
}

variable "bastion_tags" {
  description = "A list of tags applied to your bastion instance."
  type        = list(string)
  default     = ["bastion"]
}

variable "cloudflare_api_token" {
  type      = string
  sensitive = true
}

variable "vpc_name" {
  type = string
}

variable "subnetwork_name" {
  type = string
}
