variable "location" {
  type    = string
  default = "us-west-2"
}

variable "dev_bootstrap_role" {
  type = string
}

variable "organisation" {
  type    = string
  default = "Innovate-Future-Foundation"
}

variable "org_abbr" {
  type    = string
  default = "inff"
}

variable "repo_env" {
  type    = string
  default = "Development"
}

variable "sso_repo" {
  type    = string
  default = "access-control"
}

variable "repos" {
  type = list(string)
  default = [
    "frontend-infrastructure",
    "server-infrastructure"
  ]
}

variable "repo_permission" {
  type = map(list(string))
  default = {
    "frontend-infrastructure" = [
      "FrontendS3Policy",
      "FrontendBucketConfigPolicy",
      "FrontendCloudFrontPolicy",
      "FrontendRoute53AcmPolicy"
    ],
    "server-infrastructure" = [
      "NetworkPowerUserPolicy",
      "CloudMapPowerUserPolicy",
    ]
  }
}

variable "oidc_provider_url" {
  description = "The URL for the OIDC token endpoint"
  type        = string
  default     = "https://token.actions.githubusercontent.com" # Default to GitHub Actions
}

variable "oidc_audience_url" {
  type    = string
  default = "sts.amazonaws.com"
}

variable "oidc_provider_thumbprint" {
  type        = string
  description = "The thumbprint of the OIDC provider"
}

