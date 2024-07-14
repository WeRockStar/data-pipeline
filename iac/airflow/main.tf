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
    cluster_ca_certificate = base64decode(var.cluster_ca_certificate)
  }
}

resource "kubernetes_namespace" "airflow" {
  metadata {
    name = "airflow"
  }
}

# resource "helm_release" "airflow" {
#   name       = "airflow"
#   namespace  = kubernetes_namespace.airflow.metadata.0.name
#   repository = "https://airflow.apache.org"
#   chart      = "apache-airflow/airflow"
#   version    = "1.14.0"
#   wait       = true
#   timeout    = 600
#   values     = [file("${path.module}/values.yaml")]
# }
