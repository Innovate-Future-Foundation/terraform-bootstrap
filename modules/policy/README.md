# AWS IAM Policy Module

This Terraform module creates and manages AWS IAM policies, specifically focused on SAML provider management and associated roles.

## Features

- Creates a custom IAM policy for SAML provider management
- Provides policy metadata and ARN mappings
- Supports resource tagging
- Manages permissions for SAML provider operations

## Usage

```hcl
module "policy" {
  source = "./modules/policy"
}
```

```hcl
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
```