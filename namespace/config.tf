
# resource "kubernetes_config_map" "config" {
#   count = length(local.config)

#   metadata {
#     name        = local.config[count.index].name
#     namespace   = var.name
#     labels      = lookup(local.config[count.index].value, "labels", {})
#     annotations = lookup(local.config[count.index].value, "annotations", {})
#   }

#   immutable   = lookup(local.config[count.index].value, "immutable", false)
#   data        = lookup(local.config[count.index].value, "data", {})
#   binary_data = lookup(local.config[count.index].value, "binary", {})

#   depends_on = [
#     kubernetes_namespace.this
#   ]
# }
