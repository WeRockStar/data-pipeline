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
    "roles/artifactregistry.reader",
    "roles/compute.networkUser"
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
  default     = ["compute.googleapis.com", "iam.googleapis.com", "container.googleapis.com", "iap.googleapis.com"]
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

variable "ip_range" {
  description = "The CIDR range for the VPC."
  type        = string
  default     = "10.0.0.0/24"
}

variable "secondary_ip_range" {
  // See https://cloud.google.com/kubernetes-engine/docs/how-to/alias-ips
  description = "The CIDR from which to allocate pod IPs for IP Aliasing."
  type        = string
  default     = "10.0.92.0/22"
}

variable "master_ipv4_cidr_block" {
  type        = string
  default     = "10.0.90.0/28"
  description = "The IP range for the master node."
}
