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
| <a name="module_project_0"></a> [project\_0](#module\_project\_0) | ./project | n/a |
| <a name="module_project_1"></a> [project\_1](#module\_project\_1) | ./project | n/a |
| <a name="module_project_2"></a> [project\_2](#module\_project\_2) | ./project | n/a |
| <a name="module_project_3"></a> [project\_3](#module\_project\_3) | ./project | n/a |
| <a name="module_project_4"></a> [project\_4](#module\_project\_4) | ./project | n/a |
| <a name="module_project_5"></a> [project\_5](#module\_project\_5) | ./project | n/a |
| <a name="module_project_6"></a> [project\_6](#module\_project\_6) | ./project | n/a |
| <a name="module_project_7"></a> [project\_7](#module\_project\_7) | ./project | n/a |
| <a name="module_project_8"></a> [project\_8](#module\_project\_8) | ./project | n/a |
| <a name="module_project_9"></a> [project\_9](#module\_project\_9) | ./project | n/a |

## Resources

| Name | Type |
|------|------|
| [helm_release.argocd](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_argocd_config_path"></a> [argocd\_config\_path](#input\_argocd\_config\_path) | ArgoCD configuration path | `string` | n/a | yes |
| <a name="input_argocd_version"></a> [argocd\_version](#input\_argocd\_version) | ArgoCD Helm chart version | `string` | `"5.19.4"` | no |
| <a name="input_default_chart"></a> [default\_chart](#input\_default\_chart) | Default ArgoCD application Helm chart from Helm repository | `string` | `"application"` | no |
| <a name="input_default_path"></a> [default\_path](#input\_default\_path) | Default ArgoCD application Helm chart from Git repository path | `string` | `null` | no |
| <a name="input_default_repository"></a> [default\_repository](#input\_default\_repository) | Default ArgoCD application repository (Git or Helm) | `string` | `"https://charts.zimagi.com"` | no |
| <a name="input_default_version"></a> [default\_version](#input\_default\_version) | Default ArgoCD application Helm chart version from Helm repository | `string` | `"0.0.1"` | no |
| <a name="input_domain"></a> [domain](#input\_domain) | Platform domain | `string` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | Platform Environment | `string` | n/a | yes |
| <a name="input_project_path"></a> [project\_path](#input\_project\_path) | Base project configuration path | `string` | n/a | yes |
| <a name="input_project_sequence"></a> [project\_sequence](#input\_project\_sequence) | Ordered collections of ArgoCD Application projects (up to 10 projects supported) | `list` | n/a | yes |
| <a name="input_role_groups"></a> [role\_groups](#input\_role\_groups) | ArgoCD Role group membership index | `map(list(string))` | `{}` | no |
| <a name="input_variables"></a> [variables](#input\_variables) | ArgoCD Application interpolation variables | `any` | `{}` | no |

## Outputs

No outputs.
