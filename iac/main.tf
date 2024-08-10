module "gke" {
  source       = "./modules/gke"
  project_name = var.project_name
  project_id   = var.project_id
  cluster_name = var.cluster_name
  region       = var.region
  node_count   = 3
  location     = var.location
}


# module "airbyte" {
#   source                 = "./airbyte"
#   cluster_name           = var.cluster_name
#   location               = var.location
#   cluster_endpoint       = module.gke.kubernetes_cluster_host
#   cluster_ca_certificate = module.gke.cluster_ca_certificate
#   zone_id                = var.zone_id
#   cloudflare_api_token   = var.cloudflare_api_token
# }

# module "airflow" {
#   source                 = "./airflow"
#   cluster_name           = var.cluster_name
#   location               = var.location
#   cluster_endpoint       = module.gke.kubernetes_cluster_host
#   cluster_ca_certificate = module.gke.cluster_ca_certificate
#   zone_id                = var.zone_id
#   cloudflare_api_token   = var.cloudflare_api_token
# }
