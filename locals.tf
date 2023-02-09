
locals {
  argocd_name        = "argocd"
  argocd_values_file = "${var.argocd_config_path}/values.yaml"

  core_variables = {
    domain      = var.domain
    environment = var.environment
  }

  variables = merge(var.variables, local.core_variables)
}
