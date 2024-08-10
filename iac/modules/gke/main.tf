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

resource "google_container_cluster" "gke_cluster" {
  name                     = var.cluster_name
  location                 = var.location
  initial_node_count       = 3
  remove_default_node_pool = true
  deletion_protection      = false
  network                  = google_compute_network.vpc_network.self_link
  subnetwork               = google_compute_subnetwork.vpc_subnetwork.self_link

  release_channel {
    channel = "STABLE"
  }

  ip_allocation_policy {
    cluster_ipv4_cidr_block  = "10.11.0.0/21"
    services_ipv4_cidr_block = "10.12.0.0/21"
  }

  # private_cluster_config {
  #   enable_private_endpoint = false
  #   enable_private_nodes    = false
  #   master_ipv4_cidr_block  = "10.13.0.0/28"
  # }

  network_policy {
    enabled  = true
    provider = "CALICO"
  }

  workload_identity_config {
    workload_pool = "${var.project_id}.svc.id.goog"
  }

  # master_authorized_networks_config {
  #   cidr_blocks {
  #     display_name = "[TF] External Control Plane access"
  #     cidr_block   = "10.0.0.7/32"
  #     # cidr_block   = join("/", [google_compute_instance.gke-bastion.network_interface[0].network_ip, "32"])
  #   }
  # }

  depends_on = [google_project_service.services]

  timeouts {
    create = "20m"
    update = "20m"
  }
}

resource "google_container_node_pool" "gke_node_pool" {
  name       = "${var.cluster_name}-node-pool"
  cluster    = google_container_cluster.gke_cluster.name
  node_count = var.node_count
  location   = var.location

  management {
    auto_repair  = true
    auto_upgrade = true
  }

  node_config {
    machine_type = "e2-standard-8"
    preemptible  = true
    disk_size_gb = 20

    service_account = google_service_account.gke.email

    oauth_scopes = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
      "https://www.googleapis.com/auth/devstorage.read_write",
      "https://www.googleapis.com/auth/cloud-platform",
      "https://www.googleapis.com/auth/service.management.readonly",
      "https://www.googleapis.com/auth/servicecontrol",
      "https://www.googleapis.com/auth/trace.append",
      "https://www.googleapis.com/auth/compute"
    ]

    labels = {
      "project" = var.project_name
    }

    shielded_instance_config {
      enable_secure_boot = true
    }

    metadata = {
      disable-legacy-endpoints         = true
      google-compute-enable-virtio-rng = true
    }
  }

  lifecycle {
    create_before_destroy = true
  }

  timeouts {
    create = "20m"
    update = "20m"
  }
}

data "google_client_config" "default" {
}

provider "helm" {
  kubernetes {
    host                   = "https://${google_container_cluster.gke_cluster.endpoint}"
    token                  = data.google_client_config.default.access_token
    cluster_ca_certificate = base64decode(google_container_cluster.gke_cluster.master_auth.0.cluster_ca_certificate)
  }
}

resource "helm_release" "nginx_ingress" {
  namespace        = "ingress-nginx"
  wait             = true
  timeout          = 600
  create_namespace = true

  name       = "ingress-nginx"
  repository = "https://kubernetes.github.io/ingress-nginx"
  chart      = "ingress-nginx"
  version    = "v4.11.0"

  values = [file("${path.module}/values/nginx.yaml")]
}

output "kubernetes_cluster_host" {
  value       = google_container_cluster.gke_cluster.endpoint
  description = "GKE Cluster Host"
  sensitive   = true
}

output "kubernetes_cluster_name" {
  value       = google_container_cluster.gke_cluster.name
  description = "GKE Cluster Name"
}

output "cluster_ca_certificate" {
  value     = google_container_cluster.gke_cluster.master_auth.0.cluster_ca_certificate
  sensitive = true
}
