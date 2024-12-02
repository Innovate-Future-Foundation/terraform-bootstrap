output "saml_policy_arn" {
  value       = aws_iam_policy.saml_provider_management.arn
  description = "ARN of the SAML provider management policy"
}

output "saml_policy_name" {
  value       = aws_iam_policy.saml_provider_management.name
  description = "Name of the SAML provider management policy"
}