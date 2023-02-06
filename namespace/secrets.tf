
resource "kubernetes_secret" "secrets" {
  for_each = var.secrets

  metadata {
    name        = each.key
    namespace   = var.name
    labels      = lookup(each.value, "labels", {})
    annotations = lookup(each.value, "annotations", {})
  }

  type        = lookup(each.value, "type", "Opaque")
  immutable   = lookup(each.value, "immutable", false)
  data        = lookup(each.value, "data", {})
  binary_data = lookup(each.value, "binary", {})

  depends_on = [
    kubernetes_namespace.this
  ]
}
