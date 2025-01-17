variable "oidc" {
  type = object({
    arn = string
    url = string
  })
  description = "OIDC provider configuration"
}

variable "organisation" {
  description = "GitHub organisation name"
  type        = string
}

variable "org_abbr" {
  description = "Organization abbreviation for naming"
  type        = string
}

variable "repo_name" {
  description = "Repository name"
  type        = string
}

variable "repo_env" {
  description = "Repository Environment"
  type        = string
}

variable "role_policies" {
  description = "List of policy names to attach to the role"
  type        = list(string)
}

variable "custom_policy_arns" {
  description = "Map of custom policy names to their ARNs"
  type        = map(string)
  default     = {}
}

variable "audience_url" {
  description = "The audience URL for the OIDC provider"
  type        = string
  default     = "sts.amazonaws.com" # Default AWS STS endpoint
}

