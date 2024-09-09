module "kubernetes_apps" {
  source = "./.."

  domain      = var.domain
  environment = var.environment

  role_groups        = local.access_config.argocd
  argocd_config_path = "${var.project_path}/argocd"
  project_path       = "${var.project_path}/projects"

  project_sequence = [
    "system",
    "platform",
    "database",
    "management"
  ]

  variables = local.variables
}
