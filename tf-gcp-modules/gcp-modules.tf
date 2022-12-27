# Enable the Cloud Run service in the project
## $ gcloud services enable run.googleapis.com

terraform {
  required_version = ">= 1.0.11"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 4.5.0"
    }
  }
}

module "cloud_run" {
  source  = "GoogleCloudPlatform/cloud-run/google"
  version = "~> 0.2.0"

  # Required variables
  service_name           = "my-app"
  project_id             = "using-terraf-xxx-xxxxxxxx"
  location               = "us-central1"
  image                  = "gcr.io/cloudrun/hello"
  members                = ["allUsers"]
}