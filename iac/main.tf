module "gke" {
  source               = "./gke"
  project_name         = var.project_name
  project_id           = var.project_id
  cloudflare_api_token = var.cloudflare_api_token
  vpc_name             = "subnet-${var.cluster_name}"
  subnetwork_name      = "subnet-${var.cluster_name}"
}
