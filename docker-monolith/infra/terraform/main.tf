provider "google" {
  version = "1.4.0"
  project = "${var.project_id}"
  region  = "${var.region}"
}

module "docker-monolith-instances" {
    source = "modules/docker-instance"
    vm_count = "${var.vm_count}"
    vm_tags = ["reddit-app","${var.docked_app_tag}","docker"]
    disk_image = "${var.os_with_docker_image}"
}

module "app-access-firewall" {
    source = "modules/reddit-app-firewall"
    app_ports = "${var.app_ports}"
    dest_tags = ["${var.docked_app_tag}"]
}
