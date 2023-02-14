
variable "name" {
  description = "Kubernetes namespace name"
  type        = string
}
variable "exists" {
  description = "If Kubernetes namespace already exists (only create secrets and config maps)"
  type        = bool
  default     = false
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
