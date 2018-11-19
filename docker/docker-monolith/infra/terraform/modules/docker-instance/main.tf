resource "google_compute_instance" "docked_app_instance" {
  name         = "docked-reddit-${format("%02d", (count.index+1))}"
  machine_type = "g1-small"
  zone         = "${var.zone}"
  tags         = "${var.vm_tags}"
  count        = "${var.vm_count}"

  boot_disk {
    initialize_params {
      image = "${var.disk_image}"
    }
  }

  network_interface {
    network = "default"

    access_config {}
  }

  metadata {
    ssh-keys = "${var.app_username}:${file("${var.public_key_path}")}"
  }
}
