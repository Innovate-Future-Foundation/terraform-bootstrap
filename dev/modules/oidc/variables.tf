variable "provider_url" {
  type    = string
  default = "https://token.actions.githubusercontent.com"
}

variable "audience_url" {
  type    = string
  default = "sts.amazonaws.com"
}

# This also allow manual input for thumbprint, in case the data block cannot fetch the tls cert
variable "provider_thumbprint" {
  type = string

  # validation {
  #   condition     = length(var.provider_thumbprint) == 40
  #   error_message = "The length of oidc provider thumbprint must be exact 40"
  # }
}
