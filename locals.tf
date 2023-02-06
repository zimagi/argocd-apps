
locals {
  argocd_name        = "argocd"
  argocd_values_file = "${var.config_path}/${var.values_directory}/argocd.yaml"

  core_variables = {
    domain      = var.domain
    environment = var.environment
  }
}

module "variables" {
  source = "Invicton-Labs/deepmerge/null"
  maps   = [local.core_variables, var.variables]
}
locals {
  variables = module.variables.merged
}

module "secrets" {
  source = "Invicton-Labs/deepmerge/null"
  maps = [
    for file in fileset(var.config_path, "${var.secrets_directory}/*.yaml") :
    yamldecode(templatefile("${var.config_path}/${file}", local.variables))
  ]
}
locals {
  secrets = module.secrets.merged
}

module "config" {
  source = "Invicton-Labs/deepmerge/null"
  maps = [
    for file in fileset(var.config_path, "${var.config_directory}/*.yaml") :
    yamldecode(templatefile("${var.config_path}/${file}", local.variables))
  ]
}
locals {
  config = module.config.merged
}
