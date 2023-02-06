
resource "kubernetes_config_map" "config" {
  for_each = nonsensitive(var.config)

  metadata {
    name        = each.key
    namespace   = var.name
    labels      = lookup(each.value, "labels", {})
    annotations = lookup(each.value, "annotations", {})
  }

  immutable   = lookup(each.value, "immutable", false)
  data        = lookup(each.value, "data", {})
  binary_data = lookup(each.value, "binary", {})

  depends_on = [
    kubernetes_namespace.this
  ]
}
