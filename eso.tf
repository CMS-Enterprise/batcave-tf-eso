
resource "helm_release" "external_secrets_operator" {
  namespace  = var.helm_namespace
  name       = var.helm_name
  repository = "https://github.com/external-secrets/external-secrets"
  chart      = "external-secrets"
  set {
    name  = "image.repository"
    value = var.imagerepo
  }
  set {
    name  = "controller.serviceAccount.name"
    value = var.serviceAccountName
  }
  set {
    name  = "node.serviceAccount.name"
    value = var.serviceAccountName
  }
  set {
    name  = "controller.serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
    value = module.external_secrets_irsa.iam_role_arn
  }
  set {
    name  = "node.serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
    value = module.external_secrets_irsa.iam_role_arn
  }

  dynamic "set" {
    for_each = var.tolerations
    content {
      name  = "controller.tolerations[${set.key}].key"
      value = set.value.key
    }
  }
}
