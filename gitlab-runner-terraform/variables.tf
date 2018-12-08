
variable "runners_count" {
    type = "string"
    description = "number of runners to create"
    default = "1"
}

variable "gitlab_url" {
    type = "string"
    description = "URL of my gitlab server"
}

variable "gitlab_token" {
    type = "string"
    description = "Registration token for gitlab runner"
}

variable "docker_host" {
    type = "string"
    description = "url to connect to docker host"
    default = "tcp://127.0.0.1:2376/"
}

variable "docker_tls_verify" {
    type = "string"
    description = "environment var for docker provisioner"
    default = "1"
}

variable "docker_machine_name" {
    type = "string"
    description = "env var for docker provision"
}

variable "docker_cert_path" {
    type = "string"
    description = "env var for docker provision"
    default = ""
}
