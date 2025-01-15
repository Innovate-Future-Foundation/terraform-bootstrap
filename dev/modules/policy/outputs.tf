output "saml_policy_arn" {
  value       = aws_iam_policy.saml_provider_management.arn
  description = "ARN of the SAML provider management policy"
}

output "saml_policy_name" {
  value       = aws_iam_policy.saml_provider_management.name
  description = "Name of the SAML provider management policy"
}

output "custom_policy_arns" {
  description = "Map of custom policy names to their ARNs"
  value       = local.custom_policy_arns
}

output "policy_metadata" {
  description = "Complete policy metadata including ARNs and descriptions"
  value       = local.policy_metadata
}