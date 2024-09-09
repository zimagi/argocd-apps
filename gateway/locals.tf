locals {
  access_config = yamldecode(file("${var.project_path}/access.yml"))

  oauth_emails = tolist(toset(flatten([
    for group, emails in local.access_config.ingress : emails
  ])))

  oauth_access_groups = {
    for group, emails in local.access_config.ingress :
    group => join(",", emails)
  }
}

#
# Autogenerated tokens
#
resource "random_password" "argocd_server_secret" {
  length           = 20
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

#
# Application variables
#
locals {
  variables = merge(var.variables, sensitive({
    DOMAIN                = var.domain
    ENVIRONMENT           = var.environment
    PROJECT_PATH          = var.project_path
    KUBE_CONFIG           = var.kube_config
    ARGOCD_SERVER_SECRET  = random_password.argocd_server_secret.result
    ARGOCD_ADMIN_PASSWORD = var.argocd_admin_password
  }))
}
