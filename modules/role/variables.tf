variable "oidc" {
  type = object({
    arn = string
    url = string
  })
}

variable "role_policies" {
  type = list(string)
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
