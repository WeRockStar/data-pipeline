resource "google_project_service" "services" {
  count   = length(var.services)
  project = var.project_id
  service = var.services[count.index]

  timeouts {
    create = "10m"
    update = "10m"
  }

  disable_on_destroy = true
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
  initial_node_count       = var.node_count
  remove_default_node_pool = true
  deletion_protection      = false
  resource_labels = {
    "project" = var.project_name
  }

  release_channel {
    channel = "STABLE"
  }

  network_policy {
    enabled  = true
    provider = "CALICO"
  }

  private_cluster_config {
    enable_private_endpoint = false
    enable_private_nodes    = true
    master_ipv4_cidr_block  = "10.0.90.0/28"
  }

  workload_identity_config {
    workload_pool = "${var.project_id}.svc.id.goog"
  }

  network    = var.vpc_name
  subnetwork = var.subnetwork_name

  master_authorized_networks_config {
    cidr_blocks {
      display_name = "[TF] External Control Plane access"
      cidr_block   = join("/", [google_compute_instance.gke-bastion.network_interface[0].access_config[0].nat_ip, "32"])
    }
  }

  depends_on = [google_project_service.services]
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

    workload_metadata_config {
      mode = "GKE_METADATA"
    }
  }

  timeouts {
    create = "20m"
    update = "20m"
  }
}

data "google_client_config" "default" {

}

data "google_container_cluster" "gke" {
  name     = var.cluster_name
  location = var.location

  depends_on = [google_container_cluster.gke_cluster]
}

provider "kubernetes" {
  host                   = "https://${google_container_cluster.gke_cluster.endpoint}"
  token                  = data.google_client_config.default.access_token
  cluster_ca_certificate = base64decode(google_container_cluster.gke_cluster.master_auth.0.cluster_ca_certificate)
}

provider "helm" {
  kubernetes {
    host                   = "https://${google_container_cluster.gke_cluster.endpoint}"
    token                  = data.google_client_config.default.access_token
    cluster_ca_certificate = base64decode(google_container_cluster.gke_cluster.master_auth.0.cluster_ca_certificate)
  }
}

resource "helm_release" "airbyte" {
  name             = "airbyte"
  namespace        = "airbyte"
  create_namespace = true
  repository       = "https://airbytehq.github.io/helm-charts"
  chart            = "airbyte"
  version          = "0.135.1"

  values = [file("${path.module}/values/airbyte.yaml")]
}
