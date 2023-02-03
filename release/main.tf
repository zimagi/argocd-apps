
module "config" {
    source      = "../config"
    config_path = var.config_path
    group       = var.group
    variables   = var.variables
}

resource "helm_release" "applications" {
  name       = "argocd-${var.group}"
  repository = "https://charts.zimagi.com"
  chart      = "argocd-apps"
  version    = var.apps_version
  namespace  = "argocd"

  force_update     = false
  recreate_pods    = false
  reuse_values     = true
  create_namespace = false

  values = [
    module.config.yaml
  ]
}
