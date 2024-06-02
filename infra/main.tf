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

resource "google_service_account" "gke" {
  account_id   = "${var.cluster_name}-sa"
  display_name = "[TF] Service Account for GKE"
}

resource "google_project_iam_binding" "gke_sa" {
  for_each = toset(var.sa-roles)

  project = var.project_id
  role    = each.value
  members = [
    "serviceAccount:${google_service_account.gke.email}"
  ]
}

resource "google_compute_network" "vpc_network" {
  name                    = "vpc-${var.cluster_name}"
  auto_create_subnetworks = false
}

resource "google_container_cluster" "gke_cluster" {
  name                     = var.cluster_name
  location                 = var.location
  initial_node_count       = var.node_count
  remove_default_node_pool = true
  deletion_protection      = false
  resource_labels = {
    "project" = var.cluster_name
  }
  release_channel {
    channel = "STABLE"
  }

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
  name       = "${var.cluster_name}-node-pool"
  cluster    = google_container_cluster.gke_cluster.name
  node_count = var.node_count
  location   = var.location

  node_config {
    machine_type = "e2-medium"
    preemptible  = true
    disk_size_gb = 10

    service_account = google_service_account.gke.email

    oauth_scopes = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
      "https://www.googleapis.com/auth/devstorage.read_write",
      "https://www.googleapis.com/auth/cloud-platform",
      "https://www.googleapis.com/auth/service.management.readonly",
      "https://www.googleapis.com/auth/servicecontrol",
      "https://www.googleapis.com/auth/trace.append"
    ]

    labels = {
      "project" = var.cluster_name
    }
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
