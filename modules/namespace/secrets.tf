
resource "kubernetes_secret" "secrets" {
  for_each = try(nonsensitive(local.secret_names), local.secret_names)

  metadata {
    name      = each.value
    namespace = var.name

    labels = merge(
      local.secrets != null ? (lookup(local.secrets, each.value, null) != null ? lookup(local.secrets[each.value], "labels", null) : null) : null,
      local.extra_secrets != null ? (lookup(local.extra_secrets, each.value, null) != null ? lookup(local.extra_secrets[each.value], "labels", null) : null) : null
    )
    annotations = merge(
      local.secrets != null ? (lookup(local.secrets, each.value, null) != null ? lookup(local.secrets[each.value], "annotations", null) : null) : null,
      local.extra_secrets != null ? (lookup(local.extra_secrets, each.value, null) != null ? lookup(local.extra_secrets[each.value], "annotations", null) : null) : null
    )
  }

  type = coalesce(
    local.secrets != null ? (lookup(local.secrets, each.value, null) != null ? lookup(local.secrets[each.value], "type", null) : null) : null,
    local.extra_secrets != null ? (lookup(local.extra_secrets, each.value, null) != null ? lookup(local.extra_secrets[each.value], "type", "Opaque") : "Opaque") : "Opaque"
  )
  immutable = coalesce(
    local.secrets != null ? (lookup(local.secrets, each.value, null) != null ? lookup(local.secrets[each.value], "immutable", null) : null) : null,
    local.extra_secrets != null ? (lookup(local.extra_secrets, each.value, null) != null ? lookup(local.extra_secrets[each.value], "immutable", false) : false) : false
  )

  data = sensitive(merge(
    local.secrets != null ? (lookup(local.secrets, each.value, null) != null ? lookup(local.secrets[each.value], "data", null) : null) : null,
    local.extra_secrets != null ? (lookup(local.extra_secrets, each.value, null) != null ? lookup(local.extra_secrets[each.value], "data", null) : null) : null
  ))
  binary_data = sensitive(merge(
    local.secrets != null ? (lookup(local.secrets, each.value, null) != null ? lookup(local.secrets[each.value], "binary", null) : null) : null,
    local.extra_secrets != null ? (lookup(local.extra_secrets, each.value, null) != null ? lookup(local.extra_secrets[each.value], "binary", null) : null) : null
  ))

  depends_on = [
    kubernetes_namespace.this
  ]
}
