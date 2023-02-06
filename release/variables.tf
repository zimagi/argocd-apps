
variable "config_path" {
  description = "Base configuration path"
  type        = string
}
variable "values_directory" {
  description = "Helm values directory within the base application configuration path (config_path)"
  type        = string
}

variable "group" {
  description = "ArgoCD Application group name"
  type        = string
}

variable "secrets" {
  description = "Collection of namespaced secrets to manage for cluster (outside of values files)"
  type        = any
}
variable "config" {
  description = "Collection of namespaced config maps to manage for cluster"
  type        = any
}

variable "variables" {
  description = "ArgoCD Application interpolation variables"
  type        = any
}

variable "argocd_namespace" {
  description = "ArgoCD Application namespace"
  type        = string
  default     = "argocd"
}

variable "cascade_delete" {
  type        = bool
  description = "Enable / disable cascade deletion of project resources"
  default     = true
}
variable "permissions" {
  type = list(object({
    name : string
    description : string
    policies : list(object({
      resource : string
      action : string
      object : string
    }))
    groups : list(string)
  }))
  description = "ArgoCD roles and policies for group"
  default     = []
}

variable "labels" {
  description = "ArgoCD Project and Application common labels"
  type        = map
  default     = {}
}
variable "annotations" {
  description = "ArgoCD Project and Application common annotations"
  type        = map
  default     = {}
}

variable "ignore_differences" {
  type = list(object({
    kind : string,
    group : string,
    name : string,
    jsonPointers : list(string)
  }))
  description = "Ignore differences at the specified json pointers"
  default     = []
}

variable "revision_history_limit" {
  type        = number
  description = "The number of items kept in the application's revision history"
  default     = 10
}

variable "prune" {
  type        = bool
  description = "Specifies if resources should be pruned during auto-syncing"
  default     = false
}
variable "self_heal" {
  type        = bool
  description = "Specifies if partial app sync should be executed when resources are changed only in target Kubernetes cluster and no git change detected"
  default     = false
}
variable "allow_empty" {
  type        = bool
  description = "Allows deleting all application resources during automatic syncing"
  default     = false
}
variable "sync_options" {
  type        = list(string)
  description = "A list of sync options to apply to the application"
  default     = []
}
variable "sync_validate" {
  type        = bool
  description = "Disables resource validation (equivalent to 'kubectl apply --validate=true')"
  default     = false
}

variable "retry_limit" {
  type        = number
  description = "Number of failed sync attempt retries; unlimited number of attempts if less than 0"
  default     = 5
}
variable "retry_backoff_duration" {
  type        = string
  description = "The amount to back off. Default unit is seconds, but could also be a duration (e.g. `2m`, `1h`)"
  default     = "5s"
}
variable "retry_backoff_factor" {
  type        = number
  description = "A factor to multiply the base duration after each failed retry"
  default     = 2
}
variable "retry_backoff_max_duration" {
  type        = string
  description = "The maximum amount of time allowed for the backoff strategy"
  default     = "3m"
}

variable "destination_server" {
  type        = string
  description = "Destination cluster server url"
  default     = "https://kubernetes.default.svc"
}