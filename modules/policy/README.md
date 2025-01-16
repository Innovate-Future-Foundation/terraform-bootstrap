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
