
resource "kubectl_manifest" "application" {
  count = length(local.applications)

  validate_schema  = true
  wait_for_rollout = true
  wait             = true

  yaml_body = yamlencode(try(
    nonsensitive(local.application_manifests[local.applications[count.index].name]),
    local.application_manifests[local.applications[count.index].name]
  ))

  depends_on = [
    kubectl_manifest.project
  ]
}
