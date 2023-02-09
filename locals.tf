
locals {
  argocd_name        = "argocd"
  argocd_values_file = "${var.argocd_config_path}/values.yaml"

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
