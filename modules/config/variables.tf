variable "policy_arns" {
  description = "Map of policy source modules and their ARN outputs"
  type = map(object({
    arn = string
    description = optional(string)
  }))
}