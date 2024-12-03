locals {
  # Transform the input policy ARNs into the required format
  custom_policy_arns = {
    for name, policy in var.policy_arns : name => policy.arn
  }

  # Additional configuration transformations can be added here
  policy_metadata = {
    for name, policy in var.policy_arns : name => {
      arn         = policy.arn
      description = policy.description
    }
  }
}