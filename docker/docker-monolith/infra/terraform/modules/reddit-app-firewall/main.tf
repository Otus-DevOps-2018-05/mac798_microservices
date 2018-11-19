resource "google_compute_firewall" "allow_access_to_ports" {
  name    = "allow-access-tcp-${join("-",var.app_ports)}"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = "${var.app_ports}"
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = "${var.dest_tags}"
}
