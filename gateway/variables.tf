#
# System variables
#
variable "domain" {
  description = "Platform domain"
  type        = string
}
variable "environment" {
  description = "Platform environment"
  type        = string
  default     = "local"
}

#
# Filesystem variables
#
variable "project_path" { # CI/CD project directory
  description = "Base project path"
  type        = string
}
variable "kube_config" {
  description = "Kubernetes cluster credential file"
  type        = string
}

#
# ArgoCD variables
#
variable "argocd_admin_password" {
  description = "ArgoCD administrator password (bcrypt hash)"
  type        = string
}

#
# Application variables (reactor generated)
#
variable "variables" {
  description = "Map of environment variables for interpolation into application configurations"
  type        = map(string)
}
