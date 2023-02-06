
#
# System variables
#
variable "domain" { # CI/CD global config
  description = "Platform domain"
  type        = string
}
variable "environment" { # CI/CD pipeline config
  description = "Platform Environment"
  type        = string
}

#
# Filesystem variables
#
variable "config_path" { # CI/CD project directory
  description = "Base application configuration path"
  type        = string
}
variable "secrets_directory" {
  description = "Secrets directory containing merged secrets definitions with format: namespace(map):name(map):config(map)"
  type        = string
  default     = "secrets"
}
variable "config_directory" {
  description = "Configuration directory containing merged config map definitions with format: namespace(map):name(map):config(map)"
  type        = string
  default     = "config"
}
variable "values_directory" {
  description = "Helm values directory within the base application configuration path (config_path)"
  type        = string
  default     = "values"
}

#
# ArgoCD variables
#
variable "groups" {
  description = "Ordered collections of ArgoCD Application configurations (up to 10 groups supported)"
  type        = list
}

variable "variables" {
  description = "ArgoCD Application interpolation variables"
  type        = any
  default     = {}
}

variable "argocd_version" {
  description = "ArgoCD Helm chart version"
  type        = string
  default     = "5.19.4"
}
