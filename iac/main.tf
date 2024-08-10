module "gke" {
  source       = "./modules/gke"
  project_name = var.project_name
  project_id   = var.project_id
  cluster_name = var.cluster_name
  region       = var.region
  node_count   = 3
  location     = var.location
}


module "data_storage" {
  source       = "./modules/data-storage"
  project_name = var.project_name
  project_id   = var.project_id
  region       = var.region
}
