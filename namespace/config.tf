
resource "kubernetes_config_map" "config" {
  for_each = try(nonsensitive(local.config_names), local.config_names)

  metadata {
    name        = each.value
    namespace   = var.name

    labels = merge(
      local.config != null ? (lookup(local.config, each.value, null) != null ? lookup(local.config[each.value], "labels", null) : null) : null,
      local.extra_config != null ? (lookup(local.extra_config, each.value, null) != null ? lookup(local.extra_config[each.value], "labels", null) : null) : null
    )
    annotations = merge(
      local.config != null ? (lookup(local.config, each.value, null) != null ? lookup(local.config[each.value], "annotations", null) : null) : null,
      local.extra_config != null ? (lookup(local.extra_config, each.value, null) != null ? lookup(local.extra_config[each.value], "annotations", null) : null) : null
    )
  }

  immutable = coalesce(
    local.config != null ? (lookup(local.config, each.value, null) != null ? lookup(local.config[each.value], "immutable", null) : null) : null,
    local.extra_config != null ? (lookup(local.extra_config, each.value, null) != null ? lookup(local.extra_config[each.value], "immutable", false) : false) : false
  )

  data = merge(
    local.config != null ? (lookup(local.config, each.value, null) != null ? lookup(local.config[each.value], "data", null) : null) : null,
    local.extra_config != null ? (lookup(local.extra_config, each.value, null) != null ? lookup(local.extra_config[each.value], "data", null) : null) : null
  )
  binary_data = merge(
    local.config != null ? (lookup(local.config, each.value, null) != null ? lookup(local.config[each.value], "binary", null) : null) : null,
    local.extra_config != null ? (lookup(local.extra_config, each.value, null) != null ? lookup(local.extra_config[each.value], "binary", null) : null) : null
  )

  depends_on = [
    kubernetes_namespace.this
  ]
}
