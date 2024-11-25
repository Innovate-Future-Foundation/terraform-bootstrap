locals {
  role_name   = "SAMLProviderManagementRole"
  policy_name = "SAMLProviderManagementPolicy"
}

# Define the custom IAM policy
resource "aws_iam_policy" "saml_provider_management" {
  name        = "SAMLProviderManagementPolicy"
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

# Create an IAM role
resource "aws_iam_role" "saml_role" {
  name               = "SAMLProviderManagementRole"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "sso.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
  tags = var.tags
}

# Attach the custom policy to the role
resource "aws_iam_role_policy_attachment" "saml_policy_attachment" {
  role       = aws_iam_role.saml_role.name
  policy_arn = aws_iam_policy.saml_provider_management.arn
}

# Optional: Attach AWS Managed Policies
resource "aws_iam_role_policy_attachment" "config_role_attachment" {
  role       = aws_iam_role.saml_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSConfigRoleForOrganizations"
}

resource "aws_iam_role_policy_attachment" "sso_admin_attachment" {
  role       = aws_iam_role.saml_role.name
  policy_arn = "arn:aws:iam::aws:policy/AWSSSOMemberAccountAdministrator"
}
