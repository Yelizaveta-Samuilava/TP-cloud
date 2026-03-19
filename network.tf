resource "google_compute_network" "vpc" {
  name                    = "tp-nginx-vpc"
  auto_create_subnetworks = false 
}

resource "google_compute_subnetwork" "subnet" {
  name          = "tp-nginx-subnet"
  region        = var.region
  ip_cidr_range = "10.0.1.0/24" 
  network       = google_compute_network.vpc.id
}

resource "google_compute_firewall" "allow_ssh" {
  name    = "allow-ssh"
  network = google_compute_network.vpc.name

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["0.0.0.0/0"] 
}

resource "google_compute_firewall" "allow_web" {
  name    = "allow-http"
  network = google_compute_network.vpc.name

  allow {
    protocol = "tcp"
    ports    = ["80"] # Port pour NGINX [cite: 446]
  }

  source_ranges = ["0.0.0.0/0"]
}
