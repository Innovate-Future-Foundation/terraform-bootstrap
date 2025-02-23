locals {
  central_ecr_repo_arn = "arn:aws:ecr:${var.central_ecr_region}:${var.production_account_id}:repository/${var.central_ecr_repo}"
}

data "aws_iam_policy_document" "central_ecr_tagging_policy" {
  version = "2012-10-17"
  statement {
    sid    = "AllowECRImageTagging"
    effect = "Allow"
    actions = [
      "ecr:BatchGetImage",
      "ecr:GetDownloadUrlForLayer",
      "ecr:BatchCheckLayerAvailability",
      "ecr:PutImage"
    ]
    resources = [local.central_ecr_repo_arn]
  }
  statement {
    sid       = "AllowECRAuthentication"
    effect    = "Allow"
    actions   = ["ecr:GetAuthorizationToken"]
    resources = ["*"]
  }
}

data "aws_iam_policy_document" "central_ecr_publishing_policy" {
  version = "2012-10-17"
  statement {
    sid    = "AllowECRImagePublishing"
    effect = "Allow"
    actions = [
      "ecr:BatchGetImage",
      "ecr:GetDownloadUrlForLayer",
      "ecr:BatchCheckLayerAvailability",
      "ecr:PutImage",
      "ecr:InitiateLayerUpload",
      "ecr:UploadLayerPart",
      "ecr:CompleteLayerUpload"
    ]
    resources = [local.central_ecr_repo_arn]
  }
  statement {
    sid       = "AllowECRAuthentication"
    effect    = "Allow"
    actions   = ["ecr:GetAuthorizationToken"]
    resources = ["*"]
  }
}

data "aws_iam_policy_document" "sso_management_poweruser_policy" {
  version = "2012-10-17"
  statement {
    effect = "Allow"
    actions = [
      "iam:DeleteSAMLProvider",
      "iam:CreateSAMLProvider",
      "iam:GetSAMLProvider",
    ]
    resources = ["arn:aws:iam::*:saml-provider/AWSSSO_*_DO_NOT_DELETE"]
  }
  statement {
    effect = "Allow"
    actions = [
      "iam:GetRole",
      "iam:ListAttachedRolePolicies",
      "iam:CreateRole",
      "iam:DeleteRole",
      "iam:ListRolePolicies",
      "iam:AttachRolePolicy",
      "iam:DetachRolePolicy",
    ]
    resources = ["arn:aws:iam::*:role/aws-reserved/sso.amazonaws.com/AWSReservedSSO*"]
  }
}
