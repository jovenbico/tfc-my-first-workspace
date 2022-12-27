# Create a bucket to store state files, using the GCP project ID
## $ gsutil mb gs://<GCP-project-name>
## gsutil mb gs:accessing-te-264-76edd097

terraform {
  required_version = ">= 1.0.11"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 4.5.0"
    }
  }
  backend "gcs" {
      bucket = "accessing-te-264-76edd097"
      prefix = "terraform/network"
  }
}

resource "google_compute_network" "vpc" {
  name                    = "terraform-vpc"
  auto_create_subnetworks = "false"
}

resource "google_compute_subnetwork" "subnet" {
  name          = "terraform-subnet"
  region        = "us-central1"
  network       = google_compute_network.vpc.name
  ip_cidr_range = "10.10.0.0/24"
}

output "subnet_name" {
    value = google_compute_subnetwork.subnet.name
}