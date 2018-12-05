# gcp_provider.tf
// Configure the Google Cloud provider
provider "google" {
  credentials = "${file("C:/Users/shino/doc/abnormality_detection_by_jubatus/jubatus  -d418843cdf68.json")}"
  project     = "jubatus-224508"
  region      = "asia-northeast1"
}
