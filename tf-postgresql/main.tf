terraform {
  required_providers {
    postgresql = {
      source  = "cyrilgdn/postgresql"
      version = "1.18.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.4.3"
    }
  }
}

provider "postgresql" {
  host     = "172.18.0.2"
  username = "postgres"
  password = "t0p-s3cr3t"
  sslmode  = "disable"
}