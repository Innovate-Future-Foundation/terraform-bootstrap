locals {
  # Full Repository name including Orgnisation name
  full_repo_name = "${var.orgnisation}/${var.repo_name}"

  # AWS oidc audience url
  audience_url = var.audience_url
}

# Example policy
data "aws_iam_policy" "fetched_policies" {
  for_each = toset(var.role_policies)
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

# Assign permission policy to role
resource "aws_iam_role_policy_attachments_exclusive" "example" {
  role_name   = aws_iam_role.repo_role.name
  policy_arns = [for policy in data.aws_iam_policy.fetched_policies : policy.arn]
}
