data "template_file" "startup_script" {
  template = <<EOF
sudo apt-get update -y
sudo apt-get install -y kubectl
echo "gcloud container clusters get-credentials $${cluster_name} --region $${region} --zone $${cluster_zone} --project $${project}" >> /etc/profile
EOF


  vars = {
    cluster_name = var.cluster_name
    cluster_zone = var.zone_c
    project      = var.project_id
    region       = var.region
  }
}

resource "google_service_account" "bastion" {
  account_id   = "${var.bastion_hostname}-sa"
  display_name = "[TF] GKE Bastion Service Account"
}

resource "google_project_iam_binding" "bastion_sa_roles" {
  for_each = toset(var.bastion-sa-roles)

  project = var.project_id
  role    = each.value
  members = [
    "serviceAccount:${google_service_account.bastion.email}"
  ]
}

resource "google_compute_firewall" "bastion-ssh" {
  name          = "bastion-ssh"
  network       = var.vpc_name
  direction     = "INGRESS"
  project       = var.project_id
  source_ranges = ["0.0.0.0/0"]

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  // Apply the firewall rule to the bastion host (matching the tags).
  target_tags = var.bastion_tags
}

resource "google_compute_instance" "gke-bastion" {
  name                      = var.bastion_hostname
  machine_type              = var.bastion_machine_type
  zone                      = var.zone_c
  project                   = var.project_id
  tags                      = var.bastion_tags // Apply the firewall rule to the bastion host.
  allow_stopping_for_update = true

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  shielded_instance_config {
    enable_secure_boot          = true
    enable_vtpm                 = true
    enable_integrity_monitoring = true
  }

  network_interface {
    subnetwork = var.subnetwork_name

    // Add an ephemeral external IP.
    access_config {
      network_tier = "STANDARD"
    }
  }

  timeouts {
    create = "10m"
    update = "10m"
  }

  metadata_startup_script = <<SCRIPT
    sudo apt-get update -y
    sudo apt-get install -y tinyproxy
  SCRIPT

  // Necessary scopes for administering kubernetes.
  service_account {
    email  = google_service_account.bastion.email
    scopes = ["userinfo-email", "compute-ro", "storage-ro", "cloud-platform"]
  }

  provisioner "local-exec" {
    command = <<EOF
        READY=""
        for i in $(seq 1 18); do
          if gcloud compute ssh ${var.bastion_hostname} --project ${var.project_id} --zone ${var.zone_c} --tunnel-through-iap --command uptime; then
            READY="yes"
            break;
          fi
          echo "Waiting for ${var.bastion_hostname} to initialize..."
          sleep 10;
        done

        if [[ -z $READY ]]; then
          echo "${var.bastion_hostname} failed to start in time."
          echo "Please verify that the instance starts and then re-run `terraform apply`"
          exit 1
        fi
EOF

  }

  scheduling {
    preemptible       = true
    automatic_restart = false
  }

  depends_on = [google_compute_firewall.bastion-ssh]
}
