
locals {
  argocd_values_file = "${var.config_path}/${var.values_directory}/argocd.yaml"

  core_variables = {
    domain      = var.domain
    environment = var.environment
  }
}

module "variables" {
  source = "Invicton-Labs/deepmerge/null"
  maps   = concat(local.core_variables, var.variables)
}
locals {
  variables = module.variables.merged
}
