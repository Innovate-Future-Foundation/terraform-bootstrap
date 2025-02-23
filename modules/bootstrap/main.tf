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
}

# Assume Roles with OIDC
module "repo_roles" {
  source             = "../role"
  for_each           = var.repos
  organisation       = var.organisation.name
  org_abbr           = var.organisation.abbr
  repo_name          = each.value.name
  repo_env           = var.repo_env
  role_policies      = each.value.policies
  oidc               = var.github_oidc
  custom_policy_arns = var.custom_policy_arns
}

# Bucket prefix
resource "random_password" "bucket_suffix" {
  length  = 5
  numeric = true
  special = false
  lower   = true
  upper   = false
}

# Workflow Tempfile Bucket
module "workflow_temp" {
  for_each       = var.repos
  source         = "../bucket"
  bucket_name    = "${var.organisation.abbr}-${each.value.name}-workflow-temp-${random_password.bucket_suffix.result}"
  principal_role = module.repo_roles[each.key].role_obj
  versioning     = "Disabled"
}

# Terraform states
module "terraform_state" {
  for_each = {
    for k, v in var.repos : k => v
    if v.is_tf
  }
  source         = "../bucket"
  bucket_name    = "${var.organisation.abbr}-${each.value.name}-tfstate-${random_password.bucket_suffix.result}"
  principal_role = module.repo_roles[each.key].role_obj
}

# Terraform LockIDs
module "terraform_locks" {
  for_each = {
    for k, v in var.repos : k => v
    if v.is_tf
  }
  source         = "../db"
  table_name     = "${var.organisation.abbr}-${each.value.name}-tflock"
  principal_role = module.repo_roles[each.key].role_obj
}
