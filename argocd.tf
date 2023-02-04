
resource "helm_release" "argocd" {
  name       = "argocd"
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"
  version    = var.argocd_version
  namespace  = "argocd"

  force_update      = true
  dependency_update = true
  reuse_values      = false
  create_namespace  = false
  wait_for_jobs     = true

  values = fileexists(local.argocd_values_file) ? [
    templatefile(local.argocd_values_file, local.variables)
  ] : null
}
