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
    "access-control" = ["IAMFullAccess"]
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
}
