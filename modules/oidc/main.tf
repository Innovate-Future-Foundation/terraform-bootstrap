locals {
  # Full Repository name including Orgnisation name
  full_repo_name = "${var.orgnisation}/${var.repo_name}"

  # Get rid of https://
  provider_domain = split("/", var.provider_url)[2]
}

resource "aws_iam_openid_connect_provider" "oidc" {
  url             = var.provider_url
  client_id_list  = [var.audience_url]
  thumbprint_list = [var.provider_thumbprint]
}

# Example policy
data "aws_iam_policy" "fetched_policy" {
  name = "IAMFullAccess"
}

# Describe the trust entity
data "aws_iam_policy_document" "assume_policy" {
  statement {
    effect = "Allow"
    principals {
      type        = "Federated"
      identifiers = [aws_iam_openid_connect_provider.oidc.arn]
    }
    actions = ["sts:AssumeRoleWithWebIdentity"]
    condition {
      test     = "StringEquals"
      variable = "${local.provider_domain}:aud"

      values = [var.audience_url]
    }
    condition {
      test     = "StringLike"
      variable = "${local.provider_domain}:sub"

      values = ["repo:${local.full_repo_name}:*"]
    }
  }
}

# Config trust entity authenticate conditions
resource "aws_iam_role" "remote_sts_role" {
  name               = "oidc-${var.org_abbr}-${var.repo_name}"
  assume_role_policy = data.aws_iam_policy_document.assume_policy.json
}

# Assign permission policy to role
resource "aws_iam_role_policy_attachments_exclusive" "example" {
  role_name   = aws_iam_role.remote_sts_role.name
  policy_arns = [data.aws_iam_policy.fetched_policy.arn]
}
