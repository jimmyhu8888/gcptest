provider "google-beta" {
  project = "velvety-arc-462903-a8"
}

#tfimport-terraform import google_compute_network.my_vpc  __project__/my-vpc
resource "google_compute_network" "my_vpc" {
  provider = google-beta

  name = "my-vpc"
  auto_create_subnetworks = false
}

#tfimport-terraform import google_compute_subnetwork.my_subnetwork __project__/us-central1/my-subnetwork
resource "google_compute_subnetwork" "my_subnetwork" {
  provider = google-beta

  name = "my-subnetwork"
  ip_cidr_range = "10.0.1.0/24"
  region = "us-central1"
  network = google_compute_network.my_vpc.id
}

#tfimport-terraform import google_compute_firewall.allow_ssh  __project__/allow-ssh
resource "google_compute_firewall" "allow_ssh" {
  provider = google-beta

  name = "allow-ssh"
  source_ranges = [
    "0.0.0.0/0"
  ]
  network = google_compute_network.my_vpc.id
  allow {
    protocol = "tcp"
    ports = ["22"]
  }
}

#tfimport-terraform import google_compute_instance.my_first_vm  __project__/us-central1-a/my-first-vm
resource "google_compute_instance" "my_first_vm" {
  provider = google-beta

  name = "my-first-vm"
  zone = "us-central1-a"
  machine_type = "e2-small"
  boot_disk {
    device_name = "boot"
    auto_delete = true
    initialize_params {
      image = "projects/debian-cloud/global/images/family/debian-11"
    }
  }
  network_interface {
    network = google_compute_network.my_vpc.id
    subnetwork = google_compute_subnetwork.my_subnetwork.id
    access_config {
    }
  }
}
