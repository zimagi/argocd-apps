
resource "kubernetes_config_map" "config" {
  for_each = try(nonsensitive(local.config_names), local.config_names)

  metadata {
    name        = each.value
    namespace   = var.name
    labels      = lookup(local.config[each.value], "labels", {})
    annotations = lookup(local.config[each.value], "annotations", {})
  }

  immutable   = lookup(local.config[each.value], "immutable", false)
  data        = lookup(local.config[each.value], "data", {})
  binary_data = lookup(local.config[each.value], "binary", {})

  depends_on = [
    kubernetes_namespace.this
  ]
}
