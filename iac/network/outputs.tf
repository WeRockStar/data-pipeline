output "vpc" {
  value = google_compute_network.vpc_network.self_link
}

output "subnet" {
  value = google_compute_subnetwork.vpc_subnetwork.self_link
}
