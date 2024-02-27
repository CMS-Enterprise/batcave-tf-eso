module "external_secrets_irsa" {
  source                        = "git::git@github.com:CMS-Enterprise/batcave-tf-irsa.git//.?ref=BATIAI-2296"
  role_name                     = "${var.cluster_name}-ub-external-secrets"
  role_path                     = var.iam_path
  role_permissions_boundary_arn = var.permissions_boundary
  app_name                      = "ESO"
  #ssm_secret_arns               = 
  attach_secretsmanager_policy  = true
  oidc_providers = {
    main = {
      provider_arn               = var.oidc_provider_arn
      namespace_service_accounts = var.external_secrets_service_accounts
    }
  }
}