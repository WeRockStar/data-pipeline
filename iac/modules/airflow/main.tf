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

// Unable to install airflow using helm_release resource
# resource "helm_release" "airflow" {
#   name       = "airflow"
#   namespace  = kubernetes_namespace.airflow.metadata.0.name
#   repository = "https://airflow.apache.org"
#   chart      = "apache-airflow/airflow"
#   version    = "1.14.0"
#   wait       = true
#   timeout    = 600
#   values     = [file("${path.module}/values.yaml")]

resource "null_resource" "helm_repo" {
  provisioner "local-exec" {
    command = "helm repo add apache-airflow https://airflow.apache.org"
  }
}

resource "null_resource" "helm_repo_update" {
  provisioner "local-exec" {
    command = "helm repo update"
  }

  depends_on = [null_resource.helm_repo]
}

resource "null_resource" "helm_install" {
  provisioner "local-exec" {
    command = "helm upgrade -install airflow apache-airflow/airflow --namespace airflow"
  }

  depends_on = [kubernetes_namespace.airflow, null_resource.helm_repo_update]
}

data "kubernetes_service" "service" {
  metadata {
    name      = "ingress-nginx-controller"
    namespace = "ingress-nginx"
  }
  depends_on = [null_resource.helm_install]
}

resource "cloudflare_record" "airflow_a_record" {
  name    = "airflow"
  value   = data.kubernetes_service.service.status[0].load_balancer[0].ingress[0].ip
  type    = "A"
  proxied = true
  zone_id = var.zone_id
}

resource "null_resource" "airflow_ingress" {
  provisioner "local-exec" {
    command = "kubectl apply -f ${path.module}/k8s/ingress.yaml"
  }
  depends_on = [ cloudflare_record.airflow_a_record ]
}
