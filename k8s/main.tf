data "google_client_config" "default" {

}

data "google_container_cluster" "gke" {
  name     = var.cluster_name
  location = var.location
}

provider "kubernetes" {
  host                   = "https://${data.google_container_cluster.gke.endpoint}"
  token                  = data.google_client_config.default.access_token
  cluster_ca_certificate = base64decode(data.google_container_cluster.gke.master_auth[0].cluster_ca_certificate)
}

data "kubernetes_service" "service" {
  metadata {
    name      = "ingress-nginx-controller"
    namespace = "ingress-nginx"
  }
}

resource "cloudflare_record" "airbyte_a_record" {
  name    = "airbyte"
  value   = data.kubernetes_service.service.status[0].load_balancer[0].ingress[0].ip
  type    = "A"
  proxied = true
  zone_id = var.zone_id
}

resource "cloudflare_record" "airflow_a_record" {
  name    = "airflow"
  value   = data.kubernetes_service.service.status[0].load_balancer[0].ingress[0].ip
  type    = "A"
  proxied = true
  zone_id = var.zone_id
}
