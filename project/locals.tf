
#
# Configuration and application data
#
locals {
  applications = {
    for file in fileset(var.project_path, "*/info.yaml") :
    dirname("${var.project_path}/${file}") => yamldecode(templatefile("${var.project_path}/${file}", var.variables))
  }
}

locals {
  roles = {
    for path, config in local.applications :
    config.name => fileexists("${path}/roles.yaml")
    ? merge(yamldecode(templatefile("${path}/roles.yaml", var.variables)), var.global_roles)
    : var.global_roles
  }
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
      name        = var.name
      namespace   = var.argocd_namespace
      labels      = var.labels
      annotations = var.annotations
      finalizers  = var.cascade_delete ? ["resources-finalizer.argocd.argoproj.io"] : []
    }
    spec = {
      sourceRepos = ["*"]
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

      roles = flatten([
        for app_name, app_config in local.roles : [
          for role_name, config in app_config : {
            name        = role_name,
            description = config.description,
            policies = flatten([
              for resource, policy in config.policies : [
                for action in policy.actions : [
                  for obj in lookup(policy, "objects", ["*"]) :
                  lookup(policy, "resource", resource) == "applications"
                  ? "p, proj:${var.name}:${role_name}, ${lookup(policy, "resource", resource)}, ${action}, ${var.name}/${obj}, allow"
                  : "p, proj:${var.name}:${role_name}, ${lookup(policy, "resource", resource)}, ${action}, ${obj}, allow"
                ]
              ]
            ]),
            groups = lookup(var.role_groups, role_name, [])
          }
        ]
      ])
    }
  }

  #
  # ArgoCD Application
  #
  application_manifests = {
    for path, config in local.applications :
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
        project              = var.name
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
          path           = lookup(config, "path", var.default_path)   # Git Repository only
          targetRevision = lookup(config, "version", var.default_version)

          helm = {
            releaseName     = lookup(config, "release", config.name)
            passCredentials = lookup(config, "pass_credentials", false)
            values = fileexists("${path}/values.yaml") ? try(
              nonsensitive(templatefile("${path}/values.yaml", var.variables)),
              templatefile("${path}/values.yaml", var.variables)
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
