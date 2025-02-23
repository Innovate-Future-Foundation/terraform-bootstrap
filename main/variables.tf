variable "sso_region" {
  type    = string
  default = "us-west-2"
}

variable "sso_account_id" {
  type = string
}

variable "prod_region" {
  type    = string
  default = "us-west-2"
}

variable "production_account_id" {
  type = string
}

variable "uat_region" {
  type    = string
  default = "ap-southeast-2"
}

variable "uat_account_id" {
  type = string
}

# variable "dev_regsion" {
#   type    = string
#   default = "ap-southeast-2"
# }

# variable "dev_account_id" {
#   type = string
# }

variable "bootstrap_role" {
  type = string
}

# variable "dev_bootstrap_role" {
#   type = string
# }

variable "organisation" {
  type    = string
  default = "Innovate-Future-Foundation"
}

variable "org_abbr" {
  type    = string
  default = "inff"
}

variable "oidc_provider_url" {
  description = "The URL for the OIDC token endpoint"
  type        = string
  default     = "https://token.actions.githubusercontent.com"
}

variable "oidc_audience_url" {
  type    = string
  default = "sts.amazonaws.com"
}

variable "oidc_provider_thumbprint" {
  type        = string
  description = "The thumbprint of the OIDC provider"
}

variable "central_ecr_region" {
  type = string
}

variable "central_ecr_repo" {
  type = string
}
