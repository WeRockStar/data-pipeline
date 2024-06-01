resource "google_project_service" "services" {
  count   = length(var.services)
  project = var.project_id
  service = var.services[count.index]

  timeouts {
    create = "10m"
    update = "10m"
  }

  disable_on_destroy = false
}

resource "google_compute_network" "vpc_network" {
  name                    = "vpc-${var.cluster_name}"
  auto_create_subnetworks = false
}

resource "google_container_cluster" "gke_cluster" {
  name                     = var.cluster_name
  location                 = "asia-southeast1-a"
  initial_node_count       = var.node_count
  remove_default_node_pool = true
  deletion_protection      = false


  network    = google_compute_network.vpc_network.self_link
  subnetwork = google_compute_subnetwork.vpc_subnetwork.self_link

  master_auth {
    client_certificate_config {
      issue_client_certificate = false
    }
  }

  depends_on = [google_project_service.services]
}

resource "google_compute_subnetwork" "vpc_subnetwork" {
  name          = "subnet-${var.cluster_name}"
  ip_cidr_range = "10.0.0.0/24"
  network       = google_compute_network.vpc_network.self_link
}

resource "google_container_node_pool" "gke_node_pool" {
  name       = "${var.cluster_name}-pool"
  cluster    = google_container_cluster.gke_cluster.name
  node_count = var.node_count
  location   = "asia-southeast1-a"

  node_config {
    machine_type = "e2-medium"
    preemptible  = true
  }

  timeouts {
    create = "20m"
    update = "20m"
  }
}

# Install Airbyte using Helm
# resource "helm_release" "airbyte" {
#   name       = "airbyte"
#   repository = "https://airbytehq.github.io/helm-charts"
#   chart      = "airbyte"
#   version    = "0.31.0"

#   set {
#     name  = "service.type"
#     value = "LoadBalancer"
#   }
# }
