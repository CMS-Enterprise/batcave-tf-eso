module "external_secrets_irsa" {
  source                        = "git::git@github.com:CMS-Enterprise/batcave-tf-irsa.git//.?ref=1.1.0"
  role_name                     = "${var.cluster_name}-external-secrets"
  role_path                     = var.iam_path
  role_permissions_boundary_arn = var.permissions_boundary
  app_name                      = "External_Secrets_Operator"
  asm_secret_arns               = [data.aws_secretsmanager_secret.batcave-private-registry.arn]
  attach_secretsmanager_policy  = true
  oidc_providers = {
    main = {
      provider_arn               = var.oidc_provider_arn
      namespace_service_accounts = var.external_secrets_service_accounts
    }
  }
}

data "aws_secretsmanager_secret" "batcave-private-registry" {
  name = "batcave/registry-artifactory.cloud.cms.gov"
}