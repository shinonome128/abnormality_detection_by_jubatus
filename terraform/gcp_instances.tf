# gcp_instances.tf

resource "google_compute_instance" "development" {
  name         = "development"
  machine_type = "n1-standard-1"
  zone         = "asia-northeast1-b"
  description  = "jubatus"
  tags         = ["development", "mass"]


  boot_disk {
    initialize_params {
      image = "projects/ubuntu-os-cloud/global/images/ubuntu-1804-bionic-v20181203a"
    }
  }

  scratch_disk {
  }

  // app install
  metadata_startup_script = <<EOT
#!/bin/sh 

EOT

  // ssh-key
  metadata {  
    sshKeys = "shinonome128:${file("C:/Users/shino/doc/abnormality_detection_by_jubatus/identity.pub")}"  
  }  

  network_interface {
    access_config {
      // Ephemeral IP
    }

    subnetwork = "${google_compute_subnetwork.development.name}"
  }

  service_account {
    scopes = ["userinfo-email", "compute-ro", "storage-ro", "bigquery", "monitoring"]
  }

  scheduling {
    on_host_maintenance = "MIGRATE"
    automatic_restart   = true
  }
}
