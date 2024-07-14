data "google_client_config" "default" {

}

data "google_container_cluster" "gke" {
  name     = var.cluster_name
  location = var.location
}

provider "kubernetes" {
  host                   = "https://${var.cluster_endpoint}"
  token                  = data.google_client_config.default.access_token
  cluster_ca_certificate = base64decode(var.cluster_ca_certificate)
}

provider "helm" {
  kubernetes {
    host                   = "https://${var.cluster_endpoint}"
    token                  = data.google_client_config.default.access_token
    cluster_ca_certificate = base64decode(google_container_cluster.gke_cluster.master_auth.0.cluster_ca_certificate)
  }
}

# resource "helm_release" "airbyte" {
#   name             = "airbyte"
#   namespace        = "airbyte"
#   create_namespace = true
#   repository       = "https://airbytehq.github.io/helm-charts"
#   chart            = "airbyte"
#   version          = "0.293.4"

#   # values = [file("${path.module}/values/airbyte.yaml")]
# }
