
resource "kubectl_manifest" "application" {
  for_each = try(nonsensitive(local.enabled_applications), local.enabled_applications)

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

resource "time_sleep" "wait_project" {
  create_duration = var.project_wait

  depends_on = [
    kubectl_manifest.application
  ]
}
