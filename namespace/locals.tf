
#
# Configuration and secret data
#
locals {
  secrets = sensitive([
    for name, config in var.secrets :
      {
        name = name
        value = config
      }
  ])

  config = [
    for name, config in var.config :
      {
        name = name
        value = config
      }
  ]
}
