data "template_file" "startup_script" {
  template = <<EOF
sudo apt-get update -y
sudo apt-get install -y kubectl
echo "gcloud container clusters get-credentials $${cluster_name} --zone $${cluster_zone} --project $${project}" >> /etc/profile
EOF


  vars = {
    cluster_name = var.cluster_name
    cluster_zone = var.location
    project      = var.project_id
  }
}

resource "google_compute_instance" "gke-bastion" {
  name                      = var.bastion_hostname
  machine_type              = var.bastion_machine_type
  zone                      = var.location
  project                   = var.project_id
  tags                      = var.bastion_tags
  allow_stopping_for_update = true


  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  network_interface {
    subnetwork = google_compute_subnetwork.vpc_subnetwork.self_link

    // Add an ephemeral external IP.
    access_config {
      // Implicit ephemeral IP
    }
  }

  // Ensure that when the bastion host is booted, it will have kubectl.
  # metadata_startup_script = "sudo apt-get install -y kubectl"
  metadata_startup_script = data.template_file.startup_script.rendered

  // Necessary scopes for administering kubernetes.
  service_account {
    scopes = ["userinfo-email", "compute-ro", "storage-ro", "cloud-platform"]
  }

  provisioner "local-exec" {
    interpreter = ["/bin/bash", "-c"]
    command     = <<EOF
        READY=""
        for i in $(seq 1 18); do
          if gcloud compute ssh ${var.ssh_user_bastion}@${var.bastion_hostname} --command uptime; then
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

        gcloud compute  --project ${var.project_id} scp --zone ${var.location} --recurse ../manifests ${var.ssh_user_bastion}@${var.bastion_hostname}:
EOF

  }
}
