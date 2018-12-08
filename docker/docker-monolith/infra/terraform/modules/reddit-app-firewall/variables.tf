variable app_ports {
    description = "Ports app listening to"
    default = ["22","9292"]
    type ="list"
}

variable dest_tags {
    description = "tag of vm instances to which apply this rule"
    default = ["reddit-app"]
    type = "list"
}

variable app_username {
    description = "User name to access instance"
    type = "string"
    default = "appuser"
}
