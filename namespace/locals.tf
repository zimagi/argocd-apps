#
# Namespace secrets
#
locals {
  secrets_path       = "${var.path}/secrets.yaml"
  extra_secrets_path = "${var.config_path}/${var.application}-secrets.yaml"

  secrets_raw = fileexists(local.secrets_path) ? yamldecode(
    file(local.secrets_path)
  ) : null
  core_secret_names = local.secrets_raw != null ? [
    for name, config in local.secrets_raw : name
  ] : []

  extra_secrets_raw = fileexists(local.extra_secrets_path) ? yamldecode(
    file(local.extra_secrets_path)
  ) : null
  extra_secret_names = local.extra_secrets_raw != null ? [
    for name, config in local.extra_secrets_raw : name
  ] : []

  secret_names = setunion(toset(local.core_secret_names), toset(local.extra_secret_names))

  secrets       = fileexists(local.secrets_path) ? sensitive(yamldecode(templatefile(local.secrets_path, var.variables))) : null
  extra_secrets = fileexists(local.extra_secrets_path) ? sensitive(yamldecode(templatefile(nonsensitive(local.extra_secrets_path), var.variables))) : null
}

#
# Namespace config maps
#
locals {
  config_path       = "${var.path}/config.yaml"
  extra_config_path = "${var.config_path}/${var.application}-config.yaml"

  config_raw = fileexists(local.config_path) ? yamldecode(
    file(local.config_path)
  ) : null
  core_config_names = local.config_raw != null ? [
    for name, config in local.config_raw : name
  ] : []

  extra_config_raw = fileexists(local.extra_config_path) ? yamldecode(
    file(local.extra_config_path)
  ) : null
  extra_config_names = local.extra_config_raw != null ? [
    for name, config in local.extra_config_raw : name
  ] : []

  config_names = setunion(toset(local.core_config_names), toset(local.extra_config_names))

  config_full = fileexists(local.config_path) ? yamldecode(templatefile(local.config_path, var.variables)) : null
  config      = local.config_full != null ? try(
    nonsensitive(local.config_full),
    local.config_full
  ) : null

  extra_config_full = fileexists(local.extra_config_path) ? yamldecode(templatefile(nonsensitive(local.extra_config_path), var.variables)) : null
  extra_config      = local.extra_config_full != null ? try(
    nonsensitive(local.extra_config_full),
    local.extra_config_full
  ) : null
}
