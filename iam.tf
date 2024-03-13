module "external_secrets_irsa" {
  source                        = "git::git@github.com:CMS-Enterprise/batcave-tf-irsa.git//.?ref=1.1.0"
  role_name                     = "${var.cluster_name}-external-secrets"
  role_path                     = var.iam_path
  role_permissions_boundary_arn = var.permissions_boundary
  app_name                      = "External_Secrets_Operator"
  asm_secret_arns               = local.secret_arns
  attach_secretsmanager_policy  = true
  oidc_providers = {
    main = {
      provider_arn               = var.oidc_provider_arn
      namespace_service_accounts = var.external_secrets_service_accounts
    }
  }
}

locals {
    secret_arns = [ for name in local.secret_names : "arn:aws:secretsmanager:${var.aws_region}:${var.aws_id}:secret:${name}"
    ]
    secret_names = [
        "private-registry",
        "batcave/argocd-config",
        "batcave/grafana-secret",
        "batcave/sso-secret",
        "batcave/istio-secret",
        "batcave/sonar-registry-credentials",
        "batcave/sonar-agent-api-key",
        "batcave/kiali",
        "batcave/gitlab-rails-secret-s3"
    ]
}