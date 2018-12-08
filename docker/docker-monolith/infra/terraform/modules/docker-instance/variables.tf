variable vm_count {
    description = "Number of instances to setup"
    default = "3"
    type = "string"
}

variable disk_image {
    description = "Disk image to boot with"
    default ="ubuntu"
    type = "string"
}

variable vm_tags {
    description = "Specific tags of the instance"
    type = "list"
    default = ["docked-reddit"]
}

variable public_key_path {
    description = "ssh public key to allow access"
    type = "string"
    default = "~/.ssh/id_rsa.pub"
}

variable app_username {
    description = "user name to access machine & so on"
    type = "string"
    default = "appuser"
}

variable zone {
    description = "Google Computing zone to create instances in"
    type = "string"
    default = "europe-north1-b"
}
