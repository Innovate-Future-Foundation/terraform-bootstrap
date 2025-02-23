variable "github_oidc" {
  type = object({
    arn = string
    url = string
  })
  description = "OIDC provider configuration"
}

# The organisation of your repository 
variable "organisation" {
  type = object({
    name = string
    abbr = string
  })
}

# The permissions required for each repository pipeline
variable "repos" {
  type = map(object({
    name     = string
    is_tf    = bool
    policies = list(string)
  }))
}

variable "repo_env" {
  type = string
}

variable "custom_policy_arns" {
  type    = map(string)
  default = {}
}

