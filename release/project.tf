
resource "kubectl_manifest" "project" {

  validate_schema  = true
  wait_for_rollout = true
  wait             = true

  yaml_body = yamlencode({
    apiVersion = "argoproj.io/v1alpha1"
    kind       = "AppProject"

    metadata = {
      name        = var.group
      namespace   = var.argocd_namespace
      labels      = var.labels
      annotations = var.annotations
      finalizers  = var.cascade_delete ? ["resources-finalizer.argocd.argoproj.io"] : []
    }
    spec = {
      roles : [
        for permission in var.permissions : {
          name : permission["name"],
          description : permission["description"],
          policies : [
            for policy in permission["policies"] :
            "p, proj:${var.group}:${permission["name"]}, ${policy["resource"]}, ${policy["action"]}, ${var.group}/${policy["object"]}, allow"
          ],
          groups : permission["groups"]
        }
      ]
    }
  })

  depends_on = [
    module.namespace
  ]
}
