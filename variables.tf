variable "imagerepo" {
  description = "Image for the repository"
  type        = string
  default     = "ghcr.io/external-secrets/external-secrets"
}

variable "cluster_name" {
  description = "Name of EKS cluster"
}

variable "cluster_endpoint" {
  description = "Endpoint for EKS cluster"
}

variable "cluster_certificate_authority_data" {
  description = "CA certificate data for EKS cluster"
}

variable "helm_namespace" {
  description = "Namespace for Helm chart"
  default     = "external-secrets"
}

variable "helm_name" {
  description = "Name for Helm release"
  default     = "external-secrets"
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
  default     = "ub-imagepull-es"
}

variable "external_secrets_service_accounts" {
  type = list(string)
  default = [
    "external-secrets:ub-imagepull-es"
  ]
}

variable "aws_region" {
  type = string
}

variable "aws_id" {
  type = string
}
