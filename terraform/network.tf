
resource "google_compute_network" "vpc_network" {
  name = local.vpc_name
  auto_create_subnetworks = false
  
  depends_on = [random_id.random_vpc_name]
}

resource "google_compute_subnetwork" "vpc_subnetwork" {
  name = local.vpc_subnet
  region = var.region
  network = google_compute_network.vpc_network.id
  ip_cidr_range = var.cidr

  depends_on = [google_compute_network.vpc_network]
}

resource "google_compute_firewall" "cockroachdb_ingress" {
  name    = "cockroachdb-ingress-${var.region}-${var.cluster_name_final}"
  network = google_compute_network.vpc_network.name

  allow {
    protocol = "tcp"
    ports    = ["8080", "26257"]
  }

  allow {
    protocol = "udp"
    ports    = ["53"]
  }

  # Use your CIDR ranges variable
  source_ranges = var.full_cidr

  # Ensure the rule applies to the GKE nodes by targeting the appropriate tags.
  target_tags = ["gke-node", var.cluster_name_final]
}
resource "google_compute_firewall" "cockroachdb_ssh" {
  name    = "cockroachdb-ssh-${var.region}-${var.cluster_name_final}"
  network = google_compute_network.vpc_network.name

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  # This rule currently allows SSH only from internal CIDRs.
  # If you need to allow SSH from an external IP (e.g. your workstation), add it here.
  source_ranges = var.full_cidr

  target_tags = ["gke-node", var.cluster_name_final]
}

