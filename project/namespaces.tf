
module "namespace" {
  for_each = local.applications

  source      = "../namespace"
  kube_config = var.kube_config

  name        = each.value.name
  path        = each.key
  variables   = var.variables
}
