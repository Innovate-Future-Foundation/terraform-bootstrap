terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.1"
    }
  }
}

provider "aws" {
  region = var.location
}

# Terraform state
module "terraform_state" {
  for_each    = toset(var.repos)
  source      = "./modules/bucket"
  bucket_name = "${var.org_abbr}-${each.key}-terraform-state"
}

# Terraform LockID
module "terraform_locks" {
  for_each   = toset(var.repos)
  source     = "./modules/db"
  table_name = "${var.org_abbr}-${each.key}-terraform-lock"
}

# Fetch GitHub OIDC Thumbprint
data "tls_certificate" "github" {
  url = "https://token.actions.githubusercontent.com/.well-known/openid-configuration"
}

# OIDC Assume Roles
module "terraform_roles" {
  for_each    = toset(var.repos)
  source      = "./modules/oidc"
  org_abbr    = var.org_abbr
  orgnisation = var.orgnisation
  repo_name   = each.key

  # Accept manual input for thumbprint or else try to use fetched cert
  provider_thumbprint = coalesce(var.oidc_provider_thumbprint, data.tls_certificate.github.certificates[0].sha1_fingerprint)
}
