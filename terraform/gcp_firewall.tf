# gcp_firewall.tf

resource "google_compute_firewall" "development" {
  name    = "development"
  network = "${google_compute_network.jubatus.name}"

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["22", "80", "443"]
  }

  source_ranges = ["0.0.0.0/0"]

  target_tags = ["${google_compute_instance.development.tags}"]
}
