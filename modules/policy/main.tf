terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.1"
    }
  }
}

locals {
  # Transform the input policy ARNs into the required format
  custom_policy_arns = {
    # CustomPolicy = aws_iam_policy.custom_policy.arn
  }

}

# Your common Custom Policies

# resource "aws_iam_policy" "custom_policy" {
#   name        = "CustomPolicy"
#   description = "Custom policy description"
#   policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [
#       {
#         Effect   = "Allow"
#         Action   = []
#         Resource = "arn:aws:..."
#       },
#       { ... }
#     ]
#   })
# }
