<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_kubectl"></a> [kubectl](#requirement\_kubectl) | >= 1.14.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_kubectl"></a> [kubectl](#provider\_kubectl) | >= 1.14.0 |
| <a name="provider_time"></a> [time](#provider\_time) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_namespace"></a> [namespace](#module\_namespace) | ../namespace | n/a |

## Resources

| Name | Type |
|------|------|
| [kubectl_manifest.application](https://registry.terraform.io/providers/gavinbunney/kubectl/latest/docs/resources/manifest) | resource |
| [kubectl_manifest.project](https://registry.terraform.io/providers/gavinbunney/kubectl/latest/docs/resources/manifest) | resource |
| [time_sleep.wait_project](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/sleep) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allow_empty"></a> [allow\_empty](#input\_allow\_empty) | Allows deleting all application resources during automatic syncing | `bool` | `false` | no |
| <a name="input_annotations"></a> [annotations](#input\_annotations) | ArgoCD Project and Application common annotations | `map(any)` | `{}` | no |
| <a name="input_argocd_namespace"></a> [argocd\_namespace](#input\_argocd\_namespace) | ArgoCD Application namespace | `string` | `"argocd"` | no |
| <a name="input_cascade_delete"></a> [cascade\_delete](#input\_cascade\_delete) | Enable / disable cascade deletion of project resources | `bool` | `true` | no |
| <a name="input_config_path"></a> [config\_path](#input\_config\_path) | Project configuration and secret additions path (non-versioned) | `string` | n/a | yes |
| <a name="input_default_chart"></a> [default\_chart](#input\_default\_chart) | Default ArgoCD application Helm chart from Helm repository | `string` | n/a | yes |
| <a name="input_default_path"></a> [default\_path](#input\_default\_path) | Default ArgoCD application Helm chart from Git repository path | `string` | n/a | yes |
| <a name="input_default_repository"></a> [default\_repository](#input\_default\_repository) | Default ArgoCD application repository (Git or Helm) | `string` | n/a | yes |
| <a name="input_default_version"></a> [default\_version](#input\_default\_version) | Default ArgoCD application Helm chart version from Helm repository | `string` | n/a | yes |
| <a name="input_destination_server"></a> [destination\_server](#input\_destination\_server) | Destination cluster server url | `string` | `"https://kubernetes.default.svc"` | no |
| <a name="input_global_roles"></a> [global\_roles](#input\_global\_roles) | Global ArgoCD roles across all projects | `any` | `{}` | no |
| <a name="input_ignore_differences"></a> [ignore\_differences](#input\_ignore\_differences) | Ignore differences at the specified json pointers | <pre>list(object({<br/>    kind : string,<br/>    group : string,<br/>    name : string,<br/>    jsonPointers : list(string)<br/>  }))</pre> | `[]` | no |
| <a name="input_labels"></a> [labels](#input\_labels) | ArgoCD Project and Application common labels | `map(any)` | `{}` | no |
| <a name="input_name"></a> [name](#input\_name) | ArgoCD Project name | `string` | n/a | yes |
| <a name="input_project_path"></a> [project\_path](#input\_project\_path) | Project configuration path | `string` | n/a | yes |
| <a name="input_project_wait"></a> [project\_wait](#input\_project\_wait) | The maximum amount of time allowed for project initialization | `string` | `"30s"` | no |
| <a name="input_prune"></a> [prune](#input\_prune) | Specifies if resources should be pruned during auto-syncing | `bool` | `true` | no |
| <a name="input_retry_backoff_duration"></a> [retry\_backoff\_duration](#input\_retry\_backoff\_duration) | The amount to back off. Default unit is seconds, but could also be a duration (e.g. `2m`, `1h`) | `string` | `"5s"` | no |
| <a name="input_retry_backoff_factor"></a> [retry\_backoff\_factor](#input\_retry\_backoff\_factor) | A factor to multiply the base duration after each failed retry | `number` | `2` | no |
| <a name="input_retry_backoff_max_duration"></a> [retry\_backoff\_max\_duration](#input\_retry\_backoff\_max\_duration) | The maximum amount of time allowed for the backoff strategy | `string` | `"3m"` | no |
| <a name="input_retry_limit"></a> [retry\_limit](#input\_retry\_limit) | Number of failed sync attempt retries; unlimited number of attempts if less than 0 | `number` | `5` | no |
| <a name="input_revision_history_limit"></a> [revision\_history\_limit](#input\_revision\_history\_limit) | The number of items kept in the application's revision history | `number` | `10` | no |
| <a name="input_role_groups"></a> [role\_groups](#input\_role\_groups) | ArgoCD Role group membership index | `map(list(string))` | `{}` | no |
| <a name="input_self_heal"></a> [self\_heal](#input\_self\_heal) | Specifies if partial app sync should be executed when resources are changed only in target Kubernetes cluster and no git change detected | `bool` | `true` | no |
| <a name="input_sync_options"></a> [sync\_options](#input\_sync\_options) | A list of sync options to apply to the application | `list(string)` | `[]` | no |
| <a name="input_sync_replace"></a> [sync\_replace](#input\_sync\_replace) | If the Replace=true sync option is set the Argo CD will use kubectl replace or kubectl create command to apply changes. | `bool` | `false` | no |
| <a name="input_sync_validate"></a> [sync\_validate](#input\_sync\_validate) | Disables resource validation (equivalent to 'kubectl apply --validate=true') | `bool` | `false` | no |
| <a name="input_variables"></a> [variables](#input\_variables) | ArgoCD Application interpolation variables | `any` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->