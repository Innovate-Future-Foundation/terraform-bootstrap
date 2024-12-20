terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.1"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.6.3"
    }
  }

  # Backend Skeleton
  backend "s3" {}
}

provider "aws" {
  region = var.location
}

# OIDC Provider
module "oidc_provider" {
  source              = "./modules/oidc"
  provider_thumbprint = var.oidc_provider_thumbprint
  audience_url        = var.oidc_audience_url
}

# IAM Policies
module "policy" {
  source = "./modules/policy"
  tags   = local.tags
}

# Assume Roles with OIDC
module "repo_roles" {
  source        = "./modules/role"
  for_each      = toset(var.repos)
  organisation  = var.organisation
  org_abbr      = var.org_abbr
  repo_name     = each.key
  role_policies = var.repo_permission[each.key]
  oidc          = module.oidc_provider.github

  custom_policy_arns = module.policy.custom_policy_arns

  depends_on = [module.policy]
}

# Bucket prefix
resource "random_password" "prefix" {
  length  = 5
  special = false
  lower   = true
  upper   = false
}

# Workflow Artifact
module "workflow_artifact" {
  for_each       = toset(var.repos)
  source         = "./modules/bucket"
  bucket_name    = "${var.org_abbr}-${random_password.prefix.result}-${each.key}-workflow-artifact"
  principal_role = module.repo_roles[each.key].role_obj
}

# Terraform states
module "terraform_state" {
  for_each       = toset(var.repos)
  source         = "./modules/bucket"
  bucket_name    = "${var.org_abbr}-${random_password.prefix.result}-${each.key}-tfstate"
  principal_role = module.repo_roles[each.key].role_obj
}

# Terraform LockIDs
module "terraform_locks" {
  for_each       = toset(var.repos)
  source         = "./modules/db"
  table_name     = "${var.org_abbr}-${each.key}-tflock"
  principal_role = module.repo_roles[each.key].role_obj
}

locals {
  tags = {
    ManagedBy   = "Terraform"
  }
}
