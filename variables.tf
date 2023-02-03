
variable "domain" {
  description = "Platform domain"
  type        = string
}
variable "environment" {
  description = "Platform Environment"
  type        = string
}

variable "config_path" {
  description = "Base application configuration path"
  type        = string
}
variable "values_directory" {
  description = "Helm values directory within the base application configuration path (config_path)"
  type        = string
  default     = "values"
}

variable "argocd_version" {
  description = "ArgoCD Helm chart version"
  type        = string
  default     = "5.19.4"
}
variable "argocd_apps_version" {
  description = "ArgoCD Applications Helm chart version"
  type        = string
  default     = "0.1.24"
}

variable "groups" {
  description = "Ordered collections of ArgoCD Application configurations (up to 10 groups supported)"
  type        = list
}

variable "variables" {
  description = "ArgoCD Application interpolation variables"
  type        = any
}
