variable "imagerepo" {
  description = "Image for the repository"
  type        = string
  default     = "ghcr.io/external-secrets/external-secrets"
}

variable "cluster_name" {
  description = "Name of EKS cluster"
}

variable "helm_namespace" {
  description = "Namespace for Helm chart"
  default     = "kube-system"
}

variable "helm_name" {
  description = "Name for Helm release"
  default     = "external_secrets"
}

variable "tolerations" {
  type    = list(any)
  default = []
}

variable "iam_path" {
  description = "Path of IAM role"
  type        = string
  default     = "/delegatedadmin/developer/"
}

variable "oidc_provider_arn" {
  type = string
}

variable "permissions_boundary" {
  description = "Permissions boundary ARN to use for IAM role"
  type        = string
}

variable "serviceAccountName" {
  description = "Service account for the ESO to connect to AWS IAM"
  type        = string
  default     = "imagepull-es"
}

variable "external_secrets_service_accounts" {
  type = list(string)
  default = [
    "external-secrets:imagepull-es"
  ]
}