
variable "name" {
  description = "Kubernetes namespace name"
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

variable "secrets" {
  description = "Collection of namespaced secrets to manage for cluster (outside of values files)"
  type        = any
  default     = {}
}
variable "config" {
  description = "Collection of namespaced config maps to manage for cluster"
  type        = any
  default     = {}
}
