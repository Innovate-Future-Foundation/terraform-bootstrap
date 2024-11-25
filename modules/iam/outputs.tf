output "saml_role_arn" {
  description = "ARN of the SAML Provider Management Role"
  value       = aws_iam_role.saml_role.arn
}

output "saml_policy_arn" {
  description = "ARN of the SAML Provider Management Policy"
  value       = aws_iam_policy.saml_provider_management.arn
}