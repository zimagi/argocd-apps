
resource "kubectl_manifest" "project" {

  validate_schema  = true
  wait_for_rollout = true
  wait             = true

  yaml_body = yamlencode(try(
    nonsensitive(local.project_manifest),
    local.project_manifest
  ))

  depends_on = [
    module.namespace
  ]
}
