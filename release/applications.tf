
locals {
  application_manifests = {
    for name, config in local.application_index :
      name => {
        apiVersion = "argoproj.io/v1alpha1"
        kind       = "Application"

        metadata = {
          name        = name
          namespace   = var.argocd_namespace
          labels      = merge(var.labels, lookup(config, "labels", {}))
          annotations = merge(var.annotations, lookup(config, "annotations", {}))
          finalizers  = var.cascade_delete == true ? ["resources-finalizer.argocd.argoproj.io"] : []
        }
        spec = {
          project              = var.group
          ignoreDifferences    = lookup(config, "ignore_differences", var.ignore_differences)
          revisionHistoryLimit = lookup(config, "revision_history_limit", var.revision_history_limit)

          syncPolicy = {
            automated = {
              prune      = lookup(config, "prune", var.prune)
              selfHeal   = lookup(config, "self_heal", var.self_heal)
              allowEmpty = lookup(config, "allow_empty", var.allow_empty)
            }
            syncOptions = concat(lookup(config, "sync_options", var.sync_options), [
              lookup(config, "sync_validate", var.sync_validate) ? "Validate=true" : "Validate=false",
              "CreateNamespace=false"
            ])
            retry = {
              limit = lookup(config, "retry_limit", var.retry_limit)
              backoff = {
                duration    = lookup(config, "retry_backoff_duration", var.retry_backoff_duration)
                factor      = lookup(config, "retry_backoff_factor", var.retry_backoff_factor)
                maxDuration = lookup(config, "retry_backoff_max_duration", var.retry_backoff_max_duration)
              }
            }
          }

          source = {
            repoURL        = lookup(config, "repository", var.default_repository)
            chart          = lookup(config, "chart", var.default_chart) # Helm Repository only
            path           = lookup(config, "path", var.default_path)  # Git Repository only
            targetRevision = lookup(config, "version", var.default_version)

            helm = {
              releaseName     = lookup(config, "release", name)
              passCredentials = lookup(config, "pass_credentials", false)
              values          = fileexists("${local.values_path}/${name}.yaml") ? templatefile(
                "${local.values_path}/${name}.yaml",
                var.variables
              ) : ""
            }
          }

          destination = {
            server    = lookup(config, "destination_server", var.destination_server)
            namespace = var.group
          }
        }
      }
  }
}

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
