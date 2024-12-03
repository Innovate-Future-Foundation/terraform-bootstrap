output "custom_policy_arns" {
  description = "Map of custom policy names to their ARNs"
  value       = local.custom_policy_arns
}

output "policy_metadata" {
  description = "Complete policy metadata including ARNs and descriptions"
  value       = local.policy_metadata
}