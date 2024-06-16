module "gke" {
  source       = "./gke"
  project_name = var.project_name
  project_id   = var.project_id
  cluster_name = var.cluster_name
  region       = var.region
  node_count   = 2
}

module "cloudflare" {
  source               = "./cloudflare"
  cloudflare_api_token = var.cloudflare_api_token
}
