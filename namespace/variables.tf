
variable "kube_config" {
  description = "Kubernetes cluster credential file (~/.kube/config)."
  type        = string
}

variable "name" {
  description = "Kubernetes namespace name"
  type        = string
}
variable "path" {
  description = "Project path that contains secrets and config files"
  type        = string
}

variable "labels" {
  description = "Kubernetes namespace labels"
  type        = map(any)
  default     = {}
}
variable "annotations" {
  description = "Kubernetes namespace annotations"
  type        = map(any)
  default     = {}
}

variable "variables" {
  description = "Interpolation variables"
  type        = any
}
