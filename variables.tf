variable "location" {
  type    = string
  default = "us-west-2"
}

variable "orgnisation" {
  type    = string
  default = "Innovate-Future-Foundation"
}

variable "org_abbr" {
  type    = string
  default = "inff"
}

variable "repos" {
  type    = list(string)
  default = ["access-control"]
}

variable "repo_permission" {
  type = map(list(string))
  default = {
    "access-control" = [
      "IAMFullAccess",
      "AWSConfigRoleForOrganizations",                    # For Organization management
      "AWSSSOMemberAccountAdministrator",                 # For SSO management
      "SAMLProviderManagementPolicy"
    ]
  }
}

variable "oidc_provider_url" {
  type    = string
  default = "https://token.actions.githubusercontent.com"
}

variable "oidc_audience_url" {
  type    = string
  default = "sts.amazonaws.com"
}

variable "oidc_provider_thumbprint" {
  type = string
  description = "The thumbprint of the OIDC provider"
}

variable "environment" {
  type        = string
  description = "Environment name (e.g., dev, prod, staging)"
  default     = "prod"
  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "Environment must be dev, staging, or prod"
  }
}
