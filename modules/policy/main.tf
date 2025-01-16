locals {
  role_name   = "SAMLProviderManagementRole"
  policy_name = "SAMLProviderManagementPolicy"

  # Transform the input policy ARNs into the required format
  custom_policy_arns = {
    # CustomPolicy = aws_iam_policy.custom_policy.arn
  }

}

# Your Custom Policies
# resource "aws_iam_policy" "custom_policy" {
#   policy = ""
# }