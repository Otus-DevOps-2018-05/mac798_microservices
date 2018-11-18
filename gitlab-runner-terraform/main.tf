provider "docker" {
    host = "${var.docker_host}"
}

resource "docker_container" "gitlab_runner_ctr" {
  count = "${var.runners_count}"
  name = "${format("gitlab-runner-%02d", count.index)}"
  image = "${docker_image.gitlab_runner.latest}"
  volumes {
    host_path = "/srv/gitlab-runner/config"
    container_path = "/etc/gitlab-runner"
  }
  volumes {
      host_path = "/var/run/docker.sock"
      container_path = "/var/run/docker.sock"
  }

  provisioner "local-exec" {
    environment = {
        DOCKER_TLS_VERIFY = "${var.docker_tls_verify}"
        DOCKER_MACHINE_NAME = "${var.docker_machine_name}"
        DOCKER_HOST = "${var.docker_host}"
        DOCKER_CERT_PATH = "${var.docker_cert_path != "" ? var.docker_cert_path : "~/.docker/machine/machines/${var.docker_machine_name}"}"
    }
    command = "docker exec -d ${format("gitlab-runner-%02d", count.index)} gitlab-runner register --non-interactive --url ${var.gitlab_url} --registration-token ${var.gitlab_token} --executor docker --docker-image alpine:latest --description ${format("docker-runner-%02d", count.index)} --tag-list 'docker,linux,ubuntu,xenial' --run-untagged --locked='false' && docker exec -d ${format("gitlab-runner-%02d", count.index)} gitlab-runner install -n  ${format("docker-runner-%02d", count.index)} -u root"
  }
}

resource "docker_image" "gitlab_runner" {
  name = "gitlab/gitlab-runner:latest"
}
