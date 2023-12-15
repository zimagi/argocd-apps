variable "global_name" {
  description = "The name of platform."
  type        = string
}

variable "global_root_domain" { # CI/CD global config
  description = "Platform domain"
  type        = string
}

variable "global_environment" { # CI/CD pipeline config
  description = "Platform Environment"
  type        = string
}

variable "project_path" { # CI/CD project directory
  description = "Base project path"
  type        = string
}

variable "kube_config_path" {
  description = "Kubernetes cluster credential file (~/.kube/config)."
  type        = string
  default     = "~/.kube/config"
}
