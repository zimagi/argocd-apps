
locals {
  secrets_path = "${var.path}/secrets.yaml"

  secrets_raw = fileexists(local.secrets_path) ? yamldecode(
    file(local.secrets_path)
  ) : null

  secrets = fileexists(local.secrets_path) ? sensitive(
    yamldecode(templatefile(local.secrets_path, var.variables))
  ) : null

  secret_names = toset(local.secrets_raw != null ? [
    for name, config in local.secrets_raw : name
  ] : [])
}

locals {
  config_path = "${var.path}/config.yaml"

  config_raw = fileexists(local.config_path) ? yamldecode(
    file(local.config_path)
  ) : null

  config_full = fileexists(local.config_path) ? yamldecode(
    templatefile(local.config_path, var.variables)
  ) : null

  config = fileexists(local.config_path) ? try(
    nonsensitive(local.config_full),
    local.config_full
  ) : null

  config_names = toset(local.config_raw != null ? [
    for name, config in local.config_raw : name
  ] : [])
}
