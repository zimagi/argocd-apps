
resource "kubernetes_secret" "secrets" {
  for_each = try(nonsensitive(local.secret_names), local.secret_names)

  metadata {
    name        = each.value
    namespace   = var.name
    labels      = lookup(local.secrets[each.value], "labels", {})
    annotations = lookup(local.secrets[each.value], "annotations", {})
  }

  type        = lookup(local.secrets[each.value], "type", "Opaque")
  immutable   = lookup(local.secrets[each.value], "immutable", false)
  data        = sensitive(lookup(local.secrets[each.value], "data", {}))
  binary_data = sensitive(lookup(local.secrets[each.value], "binary", {}))

  depends_on = [
    kubernetes_namespace.this
  ]
}
