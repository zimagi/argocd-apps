
resource "kubectl_manifest" "application" {
  for_each = try(nonsensitive(local.enabled_applications), local.enabled_appliciations)

  validate_schema  = true
  wait_for_rollout = true
  wait             = true

  yaml_body = yamlencode(try(
    nonsensitive(local.application_manifests[each.value.name]),
    local.application_manifests[each.value.name]
  ))

  depends_on = [
    kubectl_manifest.project
  ]
}
