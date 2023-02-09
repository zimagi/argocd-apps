
module "namespace" {
  for_each = local.applications

  source      = "../namespace"

  name        = each.value.name
  path        = each.key
  variables   = var.variables
}
