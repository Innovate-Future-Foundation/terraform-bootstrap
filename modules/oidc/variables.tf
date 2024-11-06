variable "provider_url" {
  type    = string
  default = "https://token.actions.githubusercontent.com"
}

variable "audience_url" {
  type    = string
  default = "sts.amazonaws.com"
}

variable "org_abbr" {
  type = string
}

variable "orgnisation" {
  type = string
}

variable "repo_name" {
  type = string
}

# This also allow manual input for thumbprint, in case the data block cannot fetch the tls cert
variable "provider_thumbprint" {
  type = string

  validation {
    condition     = length(var.provider_thumbprint) == 40
    error_message = "The length of oidc provider thumbprint must be exact 40"
  }
}
