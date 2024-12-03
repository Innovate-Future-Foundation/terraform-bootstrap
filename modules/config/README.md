# Configuration Module

A Terraform module for centralising and managing AWS IAM policy configurations.

## Features

- Centralised policy ARN management
- Policy metadata management

## Usage

```hcl
module "config" {
  source = "./modules/config"
  policy_arns = {
    SAMLProviderManagementPolicy = {
      arn         = module.iam_sso.saml_policy_arn
      description = "Policy for managing SAML providers"
    }
  }
}
```
