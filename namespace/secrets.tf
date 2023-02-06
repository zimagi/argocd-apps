
resource "kubernetes_secret" "secrets" {
  for_each = nonsensitive(toset([ for name, config in var.secrets : name ]))

  metadata {
    name        = each.value
    namespace   = var.name
    labels      = lookup(var.secrets[each.value], "labels", {})
    annotations = lookup(var.secrets[each.value], "annotations", {})
  }

  type        = lookup(var.secrets[each.value], "type", "Opaque")
  immutable   = lookup(var.secrets[each.value], "immutable", false)
  data        = lookup(var.secrets[each.value], "data", {})
  binary_data = lookup(var.secrets[each.value], "binary", {})

  depends_on = [
    kubernetes_namespace.this
  ]
}
