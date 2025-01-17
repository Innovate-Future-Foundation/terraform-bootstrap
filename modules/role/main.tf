terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.1"
    }
  }
}

locals {
  # Full Repository name including Organisation name
  full_repo_name = "${var.organisation}/${var.repo_name}"

  # AWS oidc audience url
  audience_url = var.audience_url

  # Separate policies based on whether they exist in custom_policy_arns
  custom_policies = [
    for policy in var.role_policies : policy
    if contains(keys(var.custom_policy_arns), policy)
  ]

  # All other policies are assumed to be AWS managed
  aws_managed_policies = [
    for policy in var.role_policies : policy
    if !contains(keys(var.custom_policy_arns), policy)
  ]
}

# Fetch AWS managed policies
data "aws_iam_policy" "managed_policies" {
  for_each = toset(local.aws_managed_policies)
  name     = each.key
}

# Describe the trust entity
data "aws_iam_policy_document" "assume_policy" {
  statement {
    effect = "Allow"
    principals {
      type        = "Federated"
      identifiers = [var.oidc.arn]
    }
    actions = ["sts:AssumeRoleWithWebIdentity"]
    condition {
      test     = "StringEquals"
      variable = "${var.oidc.url}:aud"

      values = [local.audience_url]
    }
    condition {
      test     = "StringLike"
      variable = "${var.oidc.url}:sub"

      values = ["repo:${local.full_repo_name}:*"]
    }
  }
}

# Config trust entity authenticate conditions
resource "aws_iam_role" "repo_role" {
  name               = "oidc-${var.org_abbr}-${var.repo_name}"
  assume_role_policy = data.aws_iam_policy_document.assume_policy.json
}

# Attach AWS managed policies
resource "aws_iam_role_policy_attachment" "managed_policy_attachment" {
  for_each = toset(local.aws_managed_policies)

  role       = aws_iam_role.repo_role.name
  policy_arn = data.aws_iam_policy.managed_policies[each.key].arn
}

# Attach custom policies
resource "aws_iam_role_policy_attachment" "custom_policy_attachment" {
  for_each = toset(local.custom_policies)

  role       = aws_iam_role.repo_role.name
  policy_arn = var.custom_policy_arns[each.value]
}
