data "google_compute_network" "vpc_network" {
  name = "vpc-${var.cluster_name}"
}

data "google_compute_subnetwork" "subnetwork" {
  name = "subnet-${var.cluster_name}"
}

module "gke" {
  source               = "./gke"
  project_name         = var.project_name
  project_id           = var.project_id
  cloudflare_api_token = var.cloudflare_api_token
  vpc_name             = data.google_compute_network.vpc_network.self_link
  subnetwork_name      = data.google_compute_subnetwork.subnetwork.self_link
  cluster_name         = var.cluster_name
  region               = var.region
  node_count           = 2
}
