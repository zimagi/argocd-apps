
variable "config_path" {
  description = "Base configuration path"
  type        = string
}

variable "group" {
  description = "ArgoCD Application group"
  type        = string
}

variable "variables" {
  description = "ArgoCD Application interpolation variables"
  type        = any
}

variable "apps_version" {
  description = "ArgoCD Applications Helm chart version"
  type        = string
}