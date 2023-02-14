
resource "kubernetes_namespace" "this" {
  count = var.exists ? 0 : 1

  metadata {
    name        = var.name
    labels      = var.labels
    annotations = var.annotations
  }
}
