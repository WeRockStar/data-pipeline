data "google_client_config" "default" {

}

data "google_container_cluster" "gke" {
  name     = var.cluster_name
  location = var.location
}

provider "kubernetes" {
  host                   = "https://${data.google_container_cluster.gke.endpoint}"
  token                  = data.google_client_config.default.access_token
  cluster_ca_certificate = base64decode(data.google_container_cluster.gke.master_auth.0.cluster_ca_certificate)
}

provider "helm" {
  kubernetes {
    host                   = "https://${data.google_container_cluster.gke.endpoint}"
    token                  = data.google_client_config.default.access_token
    cluster_ca_certificate = base64decode(data.google_container_cluster.gke.master_auth.0.cluster_ca_certificate)
  }
}

# resource "kubernetes_namespace" "airbyte" {
#   metadata {
#     name = "airbyte"
#   }
# }

# resource "helm_release" "airbyte" {
#   name       = "airbyte"
#   namespace  = kubernetes_namespace.airbyte.metadata.0.name
#   repository = "https://airbytehq.github.io/helm-charts"
#   chart      = "airbyte/airbyte"
#   version    = "0.293.4"
#   wait       = true
#   timeout    = 600
#   values     = [file("${path.module}/values.yaml")]
# }

# resource "null_resource" "helm_repo" {
#   provisioner "local-exec" {
#     command = "helm repo add airbyte https://airbytehq.github.io/helm-charts"
#   }
# }

# resource "null_resource" "helm_repo_update" {
#   provisioner "local-exec" {
#     command = "helm repo update"
#   }
#   depends_on = [null_resource.helm_repo]
# }

# resource "null_resource" "helm_install" {
#   provisioner "local-exec" {
#     command = "helm upgrade -install airbyte airbyte/airbyte --namespace airbyte"
#   }

#   depends_on = [kubernetes_namespace.airbyte, null_resource.helm_repo_update]
# }

data "kubernetes_service" "service" {
  metadata {
    name      = "ingress-nginx-controller"
    namespace = "ingress-nginx"
  }
  depends_on = [null_resource.helm_install]
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

# resource "null_resource" "airbyte_ingress" {
#   provisioner "local-exec" {
#     command = "kubectl apply -f ${path.module}/k8s/ingress.yaml"
#   }
#   depends_on = [cloudflare_record.airbyte_a_record]
# }
