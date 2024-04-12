module "external_secrets_irsa" {
  source                        = "git::git@github.com:CMS-Enterprise/batcave-tf-irsa.git//.?ref=1.1.1"
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
    secret_arns  = [ for name in local.all_secret_names : "arn:aws:secretsmanager:${var.aws_region}:${var.aws_id}:secret:${name}*" ]
    secret_names = [
        "private-registry",
        "batcave/registry-credentials",
        "batcave/argocd-config",
        "batcave/grafana-secret",
        "batcave/sso-secret",
        "batcave/istio-secret",
        "batcave/sonar-registry-credentials",
        "batcave/sonar-agent-api-key",
        "batcave/kiali",
        "batcave/alertmanager-secret",
        "batcave/loki-write-keys",
        "gitlab/access_token/flux_read_argo"
    ]
    gitlab_secret_names = [
        "batcave/gitlab-rails-secret-s3",
        "batcave/gitlab-secret",
        "batcave/gitlab-rails-secret-backup"
    ]
    defectdojo_secret_names = [
        "batcave/defectdojo",
        "batcave/defectdojo-oauth-secret",
        "batcave/defectdojo-postgresql-specific",
        "batcave/defectdojo-rabbitmq-specific",
        "batcave/defectdojo-redis-specific"
    ]
    include_gitlab_secrets     = var.enable_gitlab_secret_arns == true ? concat(local.secret_names, local.gitlab_secret_names) : local.secret_names
    all_secret_names           = var.enable_defectdojo_secret_arns == true ? concat(local.include_gitlab_secrets, local.defectdojo_secret_names) : local.include_gitlab_secrets
}

output "secret_arns"{
    value = local.secret_arns
}
