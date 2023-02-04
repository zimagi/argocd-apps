
module "config" {
    source           = "../config"
    config_path      = var.config_path
    values_directory = var.values_directory
    group            = var.group
    variables        = var.variables
}

resource "helm_release" "applications" {
  name       = "argocd-${var.group}"
  repository = "https://charts.zimagi.com"
  chart      = "argocd-apps"
  version    = var.apps_version
  namespace  = "argocd"

  force_update      = true
  dependency_update = true
  reuse_values      = false
  create_namespace  = false
  wait_for_jobs     = true

  values = [
    module.config.yaml
  ]
}
