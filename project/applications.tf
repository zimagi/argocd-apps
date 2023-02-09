
resource "kubectl_manifest" "application" {
  for_each = local.applications

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
