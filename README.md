## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_helm"></a> [helm](#provider\_helm) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_argocd"></a> [argocd](#module\_argocd) | ./namespace | n/a |
| <a name="module_config"></a> [config](#module\_config) | Invicton-Labs/deepmerge/null | n/a |
| <a name="module_release_0"></a> [release\_0](#module\_release\_0) | ./release | n/a |
| <a name="module_release_1"></a> [release\_1](#module\_release\_1) | ./release | n/a |
| <a name="module_release_2"></a> [release\_2](#module\_release\_2) | ./release | n/a |
| <a name="module_release_3"></a> [release\_3](#module\_release\_3) | ./release | n/a |
| <a name="module_release_4"></a> [release\_4](#module\_release\_4) | ./release | n/a |
| <a name="module_release_5"></a> [release\_5](#module\_release\_5) | ./release | n/a |
| <a name="module_release_6"></a> [release\_6](#module\_release\_6) | ./release | n/a |
| <a name="module_release_7"></a> [release\_7](#module\_release\_7) | ./release | n/a |
| <a name="module_release_8"></a> [release\_8](#module\_release\_8) | ./release | n/a |
| <a name="module_release_9"></a> [release\_9](#module\_release\_9) | ./release | n/a |
| <a name="module_secrets"></a> [secrets](#module\_secrets) | Invicton-Labs/deepmerge/null | n/a |
| <a name="module_variables"></a> [variables](#module\_variables) | Invicton-Labs/deepmerge/null | n/a |

## Resources

| Name | Type |
|------|------|
| [helm_release.argocd](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_argocd_version"></a> [argocd\_version](#input\_argocd\_version) | ArgoCD Helm chart version | `string` | `"5.19.4"` | no |
| <a name="input_config_directory"></a> [config\_directory](#input\_config\_directory) | Configuration directory containing merged config map definitions with format: namespace(map):name(map):config(map) | `string` | `"config"` | no |
| <a name="input_config_path"></a> [config\_path](#input\_config\_path) | Base application configuration path | `string` | n/a | yes |
| <a name="input_default_chart"></a> [default\_chart](#input\_default\_chart) | Default ArgoCD application Helm chart from Helm repository | `string` | `"application"` | no |
| <a name="input_default_path"></a> [default\_path](#input\_default\_path) | Default ArgoCD application Helm chart from Git repository path | `string` | `null` | no |
| <a name="input_default_repository"></a> [default\_repository](#input\_default\_repository) | Default ArgoCD application repository (Git or Helm) | `string` | `"https://charts.zimagi.com"` | no |
| <a name="input_default_version"></a> [default\_version](#input\_default\_version) | Default ArgoCD application Helm chart version from Helm repository | `string` | `"0.0.1"` | no |
| <a name="input_domain"></a> [domain](#input\_domain) | Platform domain | `string` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | Platform Environment | `string` | n/a | yes |
| <a name="input_groups"></a> [groups](#input\_groups) | Ordered collections of ArgoCD Application configurations (up to 10 groups supported) | `list` | n/a | yes |
| <a name="input_secrets_directory"></a> [secrets\_directory](#input\_secrets\_directory) | Secrets directory containing merged secrets definitions with format: namespace(map):name(map):config(map) | `string` | `"secrets"` | no |
| <a name="input_values_directory"></a> [values\_directory](#input\_values\_directory) | Helm values directory within the base application configuration path (config\_path) | `string` | `"values"` | no |
| <a name="input_variables"></a> [variables](#input\_variables) | ArgoCD Application interpolation variables | `any` | `{}` | no |

## Outputs

No outputs.
