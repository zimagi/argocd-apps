
module "argocd" {
  source = "./namespace"

  name      = local.argocd_name
  path      = var.argocd_config_path
  variables = local.variables
}

resource "helm_release" "argocd" {
  name       = local.argocd_name
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"
  version    = var.argocd_version
  namespace  = local.argocd_name

  force_update      = true
  dependency_update = true
  reuse_values      = false
  create_namespace  = false
  wait_for_jobs     = true

  values = fileexists(local.argocd_values_file) ? [
    nonsensitive(templatefile(local.argocd_values_file, local.variables))
  ] : null

  depends_on = [
    module.argocd
  ]
}
