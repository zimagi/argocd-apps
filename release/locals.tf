
#
# Configuration and application data
#
locals {
  values_path = "${var.config_path}/${var.values_directory}"

  applications = [
    for file in fileset(var.config_path, "${var.group}/*.yaml") :
    yamldecode(templatefile("${var.config_path}/${file}", var.variables))
  ]
}

#
# Kubernetes manifests
#
locals {
  #
  # ArgoCD Project
  #
  project_manifest = {
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
      sourceRepos  = ["*"]
      destinations = [
        {
          name      = "in-cluster"
          namespace = "*"
          server    = "https://kubernetes.default.svc"
        }
      ]
      clusterResourceWhitelist = [
        {
          group = "*"
          kind  = "*"
        }
      ]

      roles = [
        for permission in var.permissions : {
          name        = permission["name"],
          description = permission["description"],
          policies    = [
            for policy in permission["policies"] :
            "p, proj:${var.group}:${permission["name"]}, ${policy["resource"]}, ${policy["action"]}, ${var.group}/${policy["object"]}, allow"
          ],
          groups = permission["groups"]
        }
      ]
    }
  }

  #
  # ArgoCD Application
  #
  application_manifests = {
    for config in local.applications :
      config.name => {
        apiVersion = "argoproj.io/v1alpha1"
        kind       = "Application"

        metadata = {
          name        = config.name
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
              releaseName     = lookup(config, "release", config.name)
              passCredentials = lookup(config, "pass_credentials", false)
              values          = fileexists("${local.values_path}/${config.name}.yaml") ? templatefile(
                "${local.values_path}/${config.name}.yaml",
                var.variables
              ) : ""
            }
          }

          destination = {
            server    = lookup(config, "destination_server", var.destination_server)
            namespace = config.name
          }
        }
      }
  }
}
