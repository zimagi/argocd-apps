
locals {
  secrets_path = "${var.path}/secrets.yaml"

  secrets = fileexists(local.secrets_path) ? sensitive(
    yamldecode(templatefile(local.secrets_path, var.variables))
  ) : {}
}

locals {
  config_path = "${var.path}/config.yaml"

  config = fileexists(local.config_path) ? nonsensitive(
    yamldecode(templatefile(local.config_path, var.variables))
  ) : {}
}
