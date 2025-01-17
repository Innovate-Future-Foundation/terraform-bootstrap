# Management account 
provider "aws" {
  region = var.location
  alias = "management_account"
}

locals {
  sso_custom_policy = "SSOManagementPowerUser"
  # SSO Required Policies
  sso_required_policies = [
      "IAMFullAccess",
      "AWSConfigRoleForOrganizations",                    # For Organization management
      "AWSSSOMemberAccountAdministrator",                 # For SSO management
      "SSOManagementPowerUser"
    ]

  sso_tags = {
    ManagedBy   = "Terraform"
    Usage       = "SSOTerraformBootstrap"
  }
}

# OIDC Provider
module "oidc_provider" {
  providers = {
    aws = aws.management_account
  }
  source              = "../modules/oidc"
  provider_thumbprint = var.oidc_provider_thumbprint
  audience_url        = var.oidc_audience_url
}

# SSO Required Policy
resource "aws_iam_policy" "sso_custom_policy" {
  provider = aws.management_account
  name        = local.sso_custom_policy
  description = "Custom policy for managing Organisation SSO Users"
  policy      = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "iam:DeleteSAMLProvider",
          "iam:CreateSAMLProvider",
          "iam:GetSAMLProvider",
        ]
        Resource = "arn:aws:iam::*:saml-provider/AWSSSO_*_DO_NOT_DELETE"
      },
      {
        Effect = "Allow"
        Action = [
          "iam:GetRole",
          "iam:ListAttachedRolePolicies",
          "iam:CreateRole",
          "iam:DeleteRole",
          "iam:ListRolePolicies",
          "iam:AttachRolePolicy",
          "iam:DetachRolePolicy",
        ]
        Resource = "arn:aws:iam::*:role/aws-reserved/sso.amazonaws.com/AWSReservedSSO*"
      }
    ]
  })
  tags = local.sso_tags
}

# Assume Roles with OIDC
module "sso_repo_role" {
  providers = {
    aws = aws.management_account
  }
  source        = "../modules/role"
  organisation  = var.organisation
  org_abbr      = var.org_abbr
  repo_name     = var.sso_repo
  role_policies = local.sso_required_policies
  oidc          = module.oidc_provider.github

  custom_policy_arns = {
    local.sso_custom_policy = aws_iam_policy.sso_custom_policy.arn
  }
}

# Bucket prefix
resource "random_password" "sso_bucket_prefix" {
  length  = 5
  numeric = true
  special = false
  lower   = true
  upper   = false
}

# Workflow Artifact
module "sso_workflow_artifact" {
  providers = {
    aws = aws.management_account
  }
  source         = "../modules/bucket"
  bucket_name    = "${var.org_abbr}-${random_password.prefix.result}-${var.sso_repo}-workflow-artifact"
  principal_role = module.repo_roles.role_obj
}

# Terraform states
module "sso_terraform_state" {
  providers = {
    aws = aws.management_account
  }
  source         = "../modules/bucket"
  bucket_name    = "${var.org_abbr}-${random_password.prefix.result}-${var.sso_repo}-tfstate"
  principal_role = module.repo_roles.role_obj
}

# Terraform LockIDs
module "sso_terraform_locks" {
  providers = {
    aws = aws.management_account
  }
  source         = "../modules/db"
  table_name     = "${var.org_abbr}-${var.sso_repo}-tflock"
  principal_role = module.repo_roles.role_obj
}
