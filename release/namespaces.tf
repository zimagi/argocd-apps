
module "namespace" {
  count = length(local.applications)

  source  = "../namespace"
  name    = local.applications[count.index].name
  secrets = lookup(var.secrets, local.applications[count.index].name, {})
  config  = lookup(var.config, local.applications[count.index].name, {})
}
