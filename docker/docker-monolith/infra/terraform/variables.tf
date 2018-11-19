variable project_id {
    description = "Google Cloud project id"
    type = "string"
}

variable region {
    description = "Google Computing region"
    type = "string"
    default = "europe-west"
}
variable vm_count {
    description = "Number of instances to run"
    type = "string"
    default = "3"
}

variable app_ports {
    description = "Ports to allow access from elsewhere"
    type = "list"
}

variable os_with_docker_image {
    description = "image  family of os with docker ready to run"
    default = "ubuntu-docker"
    type = "string"
}

variable docked_app_tag {
    description = "Specific tag of vm instance"
    type = "string"
    default = "docked-reddit"
}
