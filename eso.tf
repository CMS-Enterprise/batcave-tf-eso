
resource "helm_release" "external_secrets_operator" {
  namespace  = var.helm_namespace
  name       = var.helm_name
  repository = "https://charts.external-secrets.io"
  version    = "v0.9.13"
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

  provider "helm" {
  kubernetes {
    host                   = var.cluster_endpoint
    cluster_ca_certificate = base64decode(var.cluster_certificate_authority_data)
    token                  = data.aws_eks_cluster_auth.cluster.token
  }
}

provider "kubernetes" {
  host                   = var.cluster_endpoint
  cluster_ca_certificate = base64decode(var.cluster_certificate_authority_data)
  token                  = data.aws_eks_cluster_auth.cluster.token
}
