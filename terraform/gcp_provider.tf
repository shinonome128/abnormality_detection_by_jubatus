# gcp_provider.tf
// Configure the Google Cloud provider
provider "google" {
  credentials = "${file("C:/Users/shino/doc/cicddemo/cicd-demo-707b32bf1a7f.json")}"
  project     = "cicd-demo-215605"
  region      = "asia-northeast1"
}
