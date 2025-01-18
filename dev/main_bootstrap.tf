# Dev account
provider "aws" {
  region = var.location
  assume_role {
    role_arn = var.dev_bootstrap_role
  }
  default_tags {
    tags = local.general_tags
  }
}

locals {
  general_tags = {
    ManagedBy = "Terraform"
    Usage     = "TerraformBootstrap"
  }
}

# OIDC Provider
module "oidc_provider" {
  source              = "../modules/oidc"
  provider_thumbprint = var.oidc_provider_thumbprint
  audience_url        = var.oidc_audience_url
}

# IAM Policies
module "custom_policy" {
  source = "../modules/policy"
}

# Assume Roles with OIDC
module "repo_roles" {
  source             = "../modules/role"
  for_each           = toset(var.repos)
  organisation       = var.organisation
  org_abbr           = var.org_abbr
  repo_name          = each.key
  repo_env           = var.repo_env
  role_policies      = var.repo_permission[each.key]
  oidc               = module.oidc_provider.github
  custom_policy_arns = module.custom_policy.custom_policy_arns
}

# Bucket prefix
resource "random_password" "bucket_suffix" {
  length  = 5
  numeric = true
  special = false
  lower   = true
  upper   = false
}

# Workflow Artifact
module "workflow_artifact" {
  for_each       = toset(var.repos)
  source         = "../modules/bucket"
  bucket_name    = "${var.org_abbr}-${each.key}-workflow-artifact-${random_password.bucket_suffix.result}"
  principal_role = module.repo_roles[each.key].role_obj
}

# Terraform states
module "terraform_state" {
  for_each       = toset(var.repos)
  source         = "../modules/bucket"
  bucket_name    = "${var.org_abbr}-${each.key}-tfstate-${random_password.bucket_suffix.result}"
  principal_role = module.repo_roles[each.key].role_obj
}

# Terraform LockIDs
module "terraform_locks" {
  for_each       = toset(var.repos)
  source         = "../modules/db"
  table_name     = "${var.org_abbr}-${each.key}-tflock"
  principal_role = module.repo_roles[each.key].role_obj
}
