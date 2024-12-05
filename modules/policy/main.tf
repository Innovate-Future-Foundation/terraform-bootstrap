locals {
  role_name   = "SAMLProviderManagementRole"
  policy_name = "SAMLProviderManagementPolicy"

  # Transform the input policy ARNs into the required format
  custom_policy_arns = {
    SAMLProviderManagementPolicy = aws_iam_policy.saml_provider_management.arn
  }

  # Policy metadata
  policy_metadata = {
    SAMLProviderManagementPolicy = {
      arn         = aws_iam_policy.saml_provider_management.arn
      description = "Policy for managing SAML providers"
    }
  }
}

# Define the custom IAM policy
resource "aws_iam_policy" "saml_provider_management" {
  name        = local.policy_name
  description = "Custom policy for managing SAML providers and associated roles"
  policy      = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "iam:DeleteSAMLProvider",
          "iam:CreateSAMLProvider",
          "iam:GetSAMLProvider",
          "iam:GetRole",
          "iam:ListAttachedRolePolicies",
          "iam:CreateRole",
          "iam:DeleteRole",
          "iam:ListRolePolicies",
          "iam:AttachRolePolicy",
          "iam:DetachRolePolicy"
        ]
        Resource = "*"
      }
    ]
  })
  tags = var.tags
}