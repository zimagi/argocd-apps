
resource "helm_release" "argocd" {
  name       = "argocd"
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"
  version    = var.argocd_version
  namespace  = "argocd"

  force_update     = false
  recreate_pods    = false
  reuse_values     = true
  create_namespace = true

  values = fileexists(local.argocd_values_file) ? [
    file(local.argocd_values_file)
  ] : null
}
