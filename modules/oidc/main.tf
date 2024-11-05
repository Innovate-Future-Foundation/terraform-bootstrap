locals {
  full_repo_name = "${var.orgnisation}/${var.repo_name}"
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
      variable = "${var.provider_url}:aud"

      values = [var.audience_url]
    }
    condition {
      test     = "StringLike"
      variable = "${var.provider_url}:aud"

      values = ["repo:${local.full_repo_name}:*"]
    }
  }
}

# Config trust entity authenticate conditions
resource "aws_iam_role" "remote_sts_role" {
  name               = var.repo_name
  assume_role_policy = data.aws_iam_policy_document.assume_policy.json
}

# Assign permission policy to role
resource "aws_iam_role_policy_attachments_exclusive" "example" {
  role_name   = aws_iam_role.remote_sts_role.name
  policy_arns = [data.aws_iam_policy.fetched_policy.arn]
}
