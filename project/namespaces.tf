
module "namespace" {
  for_each = try(nonsensitive(local.enabled_applications), local.enabled_applications)

  source = "../namespace"

  name   = lookup(each.value, "namespace", each.value.name)
  exists = lookup(each.value, "namespace_exists", false)

  path      = each.key
  variables = var.variables
}
