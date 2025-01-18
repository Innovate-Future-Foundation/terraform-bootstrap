terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.1"
    }
  }
}

# Fetch GitHub OIDC Thumbprint
data "tls_certificate" "github" {
  url = "https://token.actions.githubusercontent.com/.well-known/openid-configuration"
}

# Add github OIDC
resource "aws_iam_openid_connect_provider" "github" {
  url             = var.provider_url
  client_id_list  = [var.audience_url]
  thumbprint_list = [coalesce(var.provider_thumbprint, data.tls_certificate.github.certificates[0].sha1_fingerprint)]
}
