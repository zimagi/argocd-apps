
module "namespace" {
  for_each = local.applications

  source  = "../namespace"
  name    = each.value.name
  secrets = lookup(var.secrets, each.value.name, {})
  config  = lookup(var.config, each.value.name, {})
}
