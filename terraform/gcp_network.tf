# gcp_network.tf 

resource "google_compute_network" "cicddemo" {
  name = "cicddemo"
}
resource "google_compute_subnetwork" "development" {
  name          = "development"
  ip_cidr_range = "10.30.0.0/16"
  network       = "${google_compute_network.cicddemo.name}"
  description   = "development"
  region        = "asia-northeast1"
}
