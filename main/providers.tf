# SSO Management account
provider "aws" {
  region = var.sso_region
  alias  = "sso_account"
  default_tags {
    tags = {
      ManagedBy = "Terraform"
      Usage     = "SSOTerraformBootstrap"
      Env       = local.sso_env
    }
  }
}

# Production account 
provider "aws" {
  region = var.prod_region
  alias  = "production_account"
  default_tags {
    tags = {
      ManagedBy = "Terraform"
      Usage     = "TerraformBootstrap"
      Env       = local.prod_env
    }
  }
}

# UAT account
provider "aws" {
  region = var.uat_region
  alias  = "uat_account"
  assume_role {
    role_arn = local.uat_bootstrap_role
  }
  default_tags {
    tags = {
      ManagedBy = "Terraform"
      Usage     = "TerraformBootstrap"
      Env       = local.uat_env
    }
  }
}

# Dev account (future implementation, currently is not managed in the same org)
# provider "aws" {
#   region = var.dev_region
#   assume_role {
#     role_arn = var.dev_bootstrap_role
#   }
#   default_tags {
#     tags = {
#       ManagedBy = "Terraform"
#       Usage     = "TerraformBootstrap"
#       Env       = local.dev_env
#     }
#   }
# }

locals {
  sso_env            = "Production"
  prod_env           = "Production"
  uat_env            = "UAT"
  uat_bootstrap_role = "arn:aws:iam::${var.uat_account_id}:role/${var.bootstrap_role}"
  dev_env            = "Development"
  # dev_bootstrap_role = "arn:aws:iam::${var.dev_account_id}:role/${var.bootstrap_role}"
}
