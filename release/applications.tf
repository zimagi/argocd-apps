
resource "kubectl_manifest" "application" {
  for_each = local.application_index

  validate_schema  = true
  wait_for_rollout = true
  wait             = true

  yaml_body = yamlencode({
    apiVersion = "argoproj.io/v1alpha1"
    kind       = "Application"

    metadata = {
      name        = each.value.name
      namespace   = var.argocd_namespace
      labels      = merge(var.labels, lookup(each.value, "labels", {}))
      annotations = merge(var.annotations, lookup(each.value, "annotations", {}))
      finalizers  = var.cascade_delete == true ? ["resources-finalizer.argocd.argoproj.io"] : []
    }
    spec = {
      project              = var.group
      ignoreDifferences    = lookup(each.value, "ignore_differences", var.ignore_differences)
      revisionHistoryLimit = lookup(each.value, "revision_history_limit", var.revision_history_limit)

      syncPolicy = {
        automated = {
          prune      = lookup(each.value, "prune", var.prune)
          selfHeal   = lookup(each.value, "self_heal", var.self_heal)
          allowEmpty = lookup(each.value, "allow_empty", var.allow_empty)
        }
        syncOptions = concat(lookup(each.value, "sync_options", var.sync_options), [
          lookup(each.value, "sync_validate", var.sync_validate) ? "Validate=true" : "Validate=false",
          "CreateNamespace=false"
        ])
        retry = {
          limit = lookup(each.value, "retry_limit", var.retry_limit)
          backoff = {
            duration    = lookup(each.value, "retry_backoff_duration", var.retry_backoff_duration)
            factor      = lookup(each.value, "retry_backoff_factor", var.retry_backoff_factor)
            maxDuration = lookup(each.value, "retry_backoff_max_duration", var.retry_backoff_max_duration)
          }
        }
      }

      source = {
        repoURL        = lookup(each.value, "repository", var.default_repository)
        chart          = lookup(each.value, "chart", var.default_chart) # Helm Repository only
        path           = lookup(each.value, "path", var.default_path)  # Git Repository only
        targetRevision = lookup(each.value, "version", var.default_version)

        helm = {
          releaseName     = lookup(each.value, "release", each.value.name)
          passCredentials = lookup(each.value, "pass_credentials", false)
          # values          = fileexists("${local.values_path}/${each.value.name}.yaml") ? templatefile(
          #   "${local.values_path}/${each.value.name}.yaml",
          #   var.variables
          # ) : ""
        }
      }

      destination = {
        server    = lookup(each.value, "destination_server", var.destination_server)
        namespace = var.group
      }
    }
  })

  depends_on = [
    kubectl_manifest.project
  ]
}
