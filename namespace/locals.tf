
locals {
  secrets_path = "${var.path}/secrets.yaml"

  secrets = fileexists(local.secrets_path) ? [
    sensitive(templatefile(local.secrets_path, var.variables))
  ] : {}
}

locals {
  config_path = "${var.path}/config.yaml"

  config = fileexists(local.config_path) ? [
    nonsensitive(templatefile(local.config_path, var.variables))
  ] : {}
}
