locals {
  # Full Repository name including Orgnisation name
  full_repo_name = "${var.orgnisation}/${var.repo_name}"

  # AWS oidc audience url
  audience_url = var.audience_url

  # Separate AWS managed policies from custom policies
  aws_managed_policies = [
    for policy in var.role_policies : policy
    if !contains(["SAMLProviderManagementPolicy"], policy)
  ]

  # Only include custom policies if they exist in custom_policy_arns
  custom_policies = [
    for policy in var.role_policies : policy
    if contains(keys(var.custom_policy_arns), policy)
  ]
}

# Only fetch AWS managed policies
data "aws_iam_policy" "fetched_policies" {
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
  for_each = data.aws_iam_policy.fetched_policies

  role       = aws_iam_role.repo_role.name
  policy_arn = each.value.arn
}

# Attach custom policies only if they exist
resource "aws_iam_role_policy_attachment" "custom_policy_attachment" {
  for_each = toset(local.custom_policies)

  role       = aws_iam_role.repo_role.name
  policy_arn = var.custom_policy_arns[each.value]

  depends_on = [aws_iam_role.repo_role]
}
