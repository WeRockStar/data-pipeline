resource "google_compute_network" "vpc_network" {
  name                            = "vpc-${var.cluster_name}"
  auto_create_subnetworks         = false
  delete_default_routes_on_create = true
  routing_mode                    = "GLOBAL"
}

resource "google_compute_subnetwork" "vpc_subnetwork" {
  name                     = "subnet-${var.cluster_name}"
  ip_cidr_range            = var.ip_range
  region                   = var.region
  network                  = google_compute_network.vpc_network.self_link
  private_ip_google_access = true
  secondary_ip_range {
    range_name    = "secondary-range"
    ip_cidr_range = var.secondary_ip_range
  }
}
