
module "namespace" {
  for_each = local.applications

  source = "../namespace"

  name      = lookup(each.value, "namespace", each.value.name)
  path      = each.key
  variables = var.variables
}
