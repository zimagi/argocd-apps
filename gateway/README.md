<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_kubectl"></a> [kubectl](#requirement\_kubectl) | >= 1.14.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | 3.4.3 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_random"></a> [random](#provider\_random) | 3.4.3 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_kubernetes_apps"></a> [kubernetes\_apps](#module\_kubernetes\_apps) | ./.. | n/a |

## Resources

| Name | Type |
|------|------|
| [random_password.argocd_server_secret](https://registry.terraform.io/providers/hashicorp/random/3.4.3/docs/resources/password) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_argocd_admin_password"></a> [argocd\_admin\_password](#input\_argocd\_admin\_password) | ArgoCD administrator password (bcrypt hash) | `string` | n/a | yes |
| <a name="input_argocd_project_sequence"></a> [argocd\_project\_sequence](#input\_argocd\_project\_sequence) | ArgoCD provisioner project sequence | `list(string)` | <pre>[<br/>  "system",<br/>  "platform",<br/>  "database",<br/>  "management"<br/>]</pre> | no |
| <a name="input_domain"></a> [domain](#input\_domain) | Platform domain | `string` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | Platform environment | `string` | `"local"` | no |
| <a name="input_kube_config"></a> [kube\_config](#input\_kube\_config) | Kubernetes cluster credential file | `string` | n/a | yes |
| <a name="input_project_path"></a> [project\_path](#input\_project\_path) | Base project path | `string` | n/a | yes |
| <a name="input_variables"></a> [variables](#input\_variables) | Map of environment variables for interpolation into application configurations | `map(string)` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->