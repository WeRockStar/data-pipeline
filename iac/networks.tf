resource "google_compute_network" "vpc_network" {
  name                    = "vpc-${var.cluster_name}"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "vpc_subnetwork" {
  name          = "subnet-${var.cluster_name}"
  ip_cidr_range = "10.0.96.0/22"
  region        = var.region
  network       = google_compute_network.vpc_network.self_link
  secondary_ip_range {
    range_name    = "secondary-range"
    ip_cidr_range = var.secondary_ip_range
  }
}
