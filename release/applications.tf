
resource "kubectl_manifest" "application" {
  for_each = local.application_index

  validate_schema  = true
  wait_for_rollout = true
  wait             = true

  yaml_body = yamlencode(try(
    nonsensitive(local.application_manifests[each.key]),
    local.application_manifests[each.key]
  ))

  depends_on = [
    kubectl_manifest.project
  ]
}
