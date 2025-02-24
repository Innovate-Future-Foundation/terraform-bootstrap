locals {
  organisation = {
    name = "Innovate-Future-Foundation"
    abbr = "inff"
  }

  sso = {
    repo_env     = local.sso_env
    env_policies = local.sso_custom_policy_arns
    repos = {
      access-control = {
        name     = "access-control"
        is_tf    = true
        policies = var.sso_repo_policies.access-control
      }
    }
  }

  prod = {
    repo_env     = local.prod_env
    env_policies = local.prod_custom_policy_arns
    repos = {
      fe-infra = {
        name     = "frontend-infrastructure"
        is_tf    = true
        policies = var.prod_repo_policies.fe-infra
      }
      be-infra = {
        name     = "server-infrastructure"
        is_tf    = true
        policies = var.prod_repo_policies.be-infra
      }
      fe = {
        name     = "frontend"
        is_tf    = false
        policies = var.prod_repo_policies.fe
      }
      be = {
        name     = "server"
        is_tf    = false
        policies = var.prod_repo_policies.be
      }
    }
  }

  uat = {
    repo_env     = local.uat_env
    env_policies = local.uat_custom_policy_arns
    repos = {
      fe-infra = {
        name     = "frontend-infrastructure"
        is_tf    = true
        policies = var.uat_repo_policies.fe-infra
      }
      be-infra = {
        name     = "server-infrastructure"
        is_tf    = true
        policies = var.uat_repo_policies.be-infra
      }
      fe = {
        name     = "frontend"
        is_tf    = false
        policies = var.uat_repo_policies.fe
      }
      be = {
        name     = "server"
        is_tf    = false
        policies = var.uat_repo_policies.be
      }
    }
  }
}

# UAT
module "uat_oidc_provider" {
  providers  = { aws = aws.uat_account }
  source     = "../modules/oidc"
  thumbprint = var.oidc_provider_thumbprint
}

module "uat_custom_policy" {
  providers = { aws = aws.uat_account }
  source    = "../modules/policy"
}

module "uat_bootstrap" {
  providers  = { aws = aws.uat_account }
  source     = "../modules/bootstrap"
  depends_on = [module.uat_oidc_provider, module.uat_custom_policy]

  organisation = local.organisation
  github_oidc  = module.uat_oidc_provider.github
  custom_policy_arns = merge(
    module.uat_custom_policy.custom_policy_arns,
    local.uat.env_policies
  )
  repo_env = local.uat.repo_env
  repos    = local.uat.repos
}

# PROD
module "prod_oidc_provier" {
  providers  = { aws = aws.production_account }
  source     = "../modules/oidc"
  thumbprint = var.oidc_provider_thumbprint
}

module "prod_custom_policy" {
  providers = { aws = aws.production_account }
  source    = "../modules/policy"
}

module "prod_bootstrap" {
  providers  = { aws = aws.production_account }
  source     = "../modules/bootstrap"
  depends_on = [module.prod_oidc_provier, module.prod_custom_policy]

  organisation = local.organisation
  github_oidc  = module.prod_oidc_provier.github
  custom_policy_arns = merge(
    module.prod_custom_policy.custom_policy_arns,
    local.prod.env_policies
  )
  repo_env = local.prod.repo_env
  repos    = local.prod.repos
}

module "sso_bootstrap" {
  providers  = { aws = aws.sso_account }
  source     = "../modules/bootstrap"
  depends_on = [module.prod_oidc_provier]

  organisation       = local.organisation
  github_oidc        = module.prod_oidc_provier.github
  custom_policy_arns = local.sso.env_policies
  repo_env           = local.sso.repo_env
  repos              = local.sso.repos
}
