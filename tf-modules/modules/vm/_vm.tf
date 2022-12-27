variable "vm-name" {
  description = "Name for the VM"
}

resource "google_compute_instance" "vm" {
  name         = var.vm-name
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

output "ip" {
    value = resource.google_compute_instance.vm.network_interface.0.network_ip
}