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

variable "postgresql_username" {
  type    = string
  default = "nonsuper"
}

variable "postgresql_password" {
  type    = string
  default = "t0p-s3cr3t"
}

provider "postgresql" {
  host      = "172.18.0.2"
  username  = var.postgresql_username
  password  = var.postgresql_password
  sslmode   = "disable"
  superuser = false
}