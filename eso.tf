
resource "helm_release" "external_secrets_operator" {
  namespace        = var.helm_namespace
  name             = var.helm_name
  repository       = "https://charts.external-secrets.io"
  version          = "v0.9.13"
  chart            = "external-secrets"
  create_namespace = true
  set {
    name  = "image.repository"
    value = var.imagerepo
  }
  set {
    name  = "installCRDs"
    value = "true"
  }
  set {
    name  = "crds.createClusterExternalSecret"
    value = "true"
  }
  set {
    name  = "crds.createClusterSecretStore"
    value = "true"
  }
  set {
    name  = "serviceAccount.create"
    value = "true"
  }
  set {
    name  = "serviceAccount.name"
    value = var.serviceAccountName
  }
  set {
    name  = "serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
    value = module.external_secrets_irsa.iam_role_arn
  }
  # set {
  #   name  = "webhook.serviceAccount.name"
  #   value = var.serviceAccountName
  # }
  # set {
  #   name  = "webhook.serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
  #   value = module.external_secrets_irsa.iam_role_arn
  # }
  # set {
  #   name  = "certController.serviceAccount.name"
  #   value = var.serviceAccountName
  # }
  # set {
  #   name  = "certController.serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
  #   value = module.external_secrets_irsa.iam_role_arn
  # }
  

  dynamic "set" {
    for_each = var.tolerations
    content {
      name  = "tolerations[${set.key}].key"
      value = set.value.key
    }
  }
  dynamic "set" {
    for_each = var.tolerations
    content {
      name  = "webhook.tolerations[${set.key}].key"
      value = set.value.key
    }
  }
  dynamic "set" {
    for_each = var.tolerations
    content {
      name  = "certController.tolerations[${set.key}].key"
      value = set.value.key
    }
  }
  dynamic "set" {
    for_each = var.tolerations
    content {
      name  = "tolerations[${set.key}].value"
      value = try(set.value.value, "")
    }
  }
  dynamic "set" {
    for_each = var.tolerations
    content {
      name  = "webhook.tolerations[${set.key}].value"
      value = try(set.value.value, "")
    }
  }
  dynamic "set" {
    for_each = var.tolerations
    content {
      name  = "certController.tolerations[${set.key}].value"
      value = try(set.value.value, "")
    }
  }
  dynamic "set" {
    for_each = var.tolerations
    content {
      name  = "tolerations[${set.key}].operator"
      value = set.value.operator
    }
  }
  dynamic "set" {
    for_each = var.tolerations
    content {
      name  = "webhook.tolerations[${set.key}].operator"
      value = set.value.operator
    }
  }
  dynamic "set" {
    for_each = var.tolerations
    content {
      name  = "certController.tolerations[${set.key}].operator"
      value = set.value.operator
    }
  }
  dynamic "set" {
    for_each = var.tolerations
    content {
      name  = "tolerations[${set.key}].effect"
      value = try(set.value.effect, "NoSchedule")
    }
  }
  dynamic "set" {
    for_each = var.tolerations
    content {
      name  = "webhook.tolerations[${set.key}].effect"
      value = try(set.value.effect, "NoSchedule")
    }
  }
  dynamic "set" {
    for_each = var.tolerations
    content {
      name  = "certController.tolerations[${set.key}].effect"
      value = try(set.value.effect, "NoSchedule")
    }
  }
}
