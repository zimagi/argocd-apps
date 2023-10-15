module "ingress_namespace" {
  source = "./modules/namespace"

  name        = local.ingress_name
  application = local.ingress_name
  path        = var.ingress_config_path
  config_path = var.config_path
  variables   = local.variables
}

resource "helm_release" "ingress" {
  name       = local.ingress_name
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "nginx-ingress-controller"
  version    = var.ingress_version
  namespace  = local.ingress_name

  force_update      = true
  dependency_update = true
  reuse_values      = false
  create_namespace  = false

  wait          = true
  wait_for_jobs = true

  values = fileexists(local.ingress_values_file) ? [
    nonsensitive(templatefile(local.ingress_values_file, local.variables))
  ] : null

  depends_on = [
    module.argocd
  ]
}
