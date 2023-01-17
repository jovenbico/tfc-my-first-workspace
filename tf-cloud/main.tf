terraform {
  cloud { # get this from TFC account
    organization = "ACG-Terraform-jbf"
    workspaces { name = "my-first-workspace" }
  }
}

provider "google" {
  project = "deploying-in-269-e482bb51" # get this from sandbox environment
}

variable "GOOGLE_CREDENTIALS" {
  description = "Google Credentials (JSON)"
}

resource "google_compute_instance" "vm" {
  name         = "created-with-terraform-cloud"
  machine_type = "f1-micro"
  zone         = "us-central1-a"
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }
  network_interface {
    network = "default"
  }
}