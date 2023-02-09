
# resource "kubernetes_secret" "secrets" {
#   count = length(local.secrets)

#   metadata {
#     name        = local.secrets[count.index].name
#     namespace   = var.name
#     labels      = lookup(local.secrets[count.index].value, "labels", {})
#     annotations = lookup(local.secrets[count.index].value, "annotations", {})
#   }

#   type        = lookup(local.secrets[count.index].value, "type", "Opaque")
#   immutable   = lookup(local.secrets[count.index].value, "immutable", false)
#   data        = sensitive(lookup(local.secrets[count.index].value, "data", {}))
#   binary_data = sensitive(lookup(local.secrets[count.index].value, "binary", {}))

#   depends_on = [
#     kubernetes_namespace.this
#   ]
# }
