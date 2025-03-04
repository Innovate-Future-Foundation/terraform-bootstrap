locals {
  central_ecr_repo_arn = "arn:aws:ecr:${var.central_ecr_region}:${var.prod_account_id}:repository/${var.central_ecr_repo}"
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

data "aws_iam_policy_document" "uat_frontend_s3_poweruser_policy" {
  statement {
    effect = "Allow"
    actions = [
      "s3:ListBucket",
      "s3:GetBucketLocation",
      "s3:GetBucketPolicy",
      "s3:PutBucketPolicy",
      "s3:GetBucketAcl",
      "s3:PutBucketAcl",
      "s3:GetBucketCORS",
      "s3:PutBucketCORS",
      "s3:GetBucketWebsite",
      "s3:PutBucketWebsite",
      "s3:DeleteBucketWebsite",
      "s3:GetBucketVersioning",
      "s3:PutBucketVersioning",
      "s3:GetBucketPublicAccessBlock",
      "s3:PutBucketPublicAccessBlock",
      "s3:GetBucketEncryption",
      "s3:PutBucketEncryption",
      "s3:GetBucketRequestPayment",
      "s3:GetBucketLogging",
      "s3:PutBucketLogging",
      "s3:GetLifecycleConfiguration",
      "s3:PutLifecycleConfiguration",
      "s3:GetBucketReplication",
      "s3:PutBucketReplication",
      "s3:GetBucketTagging",
      "s3:PutBucketTagging",
      "s3:GetBucketOwnershipControls",
      "s3:PutBucketOwnershipControls",
      "s3:GetObjectLockConfiguration",
      "s3:PutObjectLockConfiguration"
    ]
    resources = [
      "arn:aws:s3:::uat-foundation-innovatefuture-uat-frontend-static",
    ]
  }
  statement {
    effect = "Allow"
    actions = [
      "s3:PutObject",
      "s3:GetObject",
      "s3:DeleteObject",
      "s3:ListMultipartUploadParts",
      "s3:AbortMultipartUpload",
      "s3:PutObjectAcl",
      "s3:GetObjectAcl",
      "s3:PutObjectTagging",
      "s3:GetObjectTagging",
      "s3:DeleteObjectTagging",
      "s3:PutObjectVersionTagging",
      "s3:GetObjectVersionTagging",
      "s3:DeleteObjectVersionTagging",
      "s3:GetObjectVersion",
      "s3:DeleteObjectVersion",
      "s3:ListMultipartUploads",
      "s3:GetObjectTorrent",
      "s3:GetObjectRetention",
      "s3:PutObjectRetention",
      "s3:GetObjectLegalHold",
      "s3:PutObjectLegalHold",
      "s3:RestoreObject",
      "s3:SelectObjectContent"
    ]
    resources = [
      "arn:aws:s3:::uat-foundation-innovatefuture-uat-frontend-static/*",
    ]
  }

  statement {
    effect = "Allow"
    actions = [
      "s3:ListAllMyBuckets",
      "s3:CreateBucket",
      "s3:DeleteBucket"
    ]
    resources = ["*"]
  }
}

data "aws_iam_policy_document" "prod_frontend_s3_poweruser_policy" {
  statement {
    effect = "Allow"
    actions = [
      "s3:ListBucket",
      "s3:GetBucketLocation",
      "s3:GetBucketPolicy",
      "s3:PutBucketPolicy",
      "s3:GetBucketAcl",
      "s3:PutBucketAcl",
      "s3:GetBucketCORS",
      "s3:PutBucketCORS",
      "s3:GetBucketWebsite",
      "s3:PutBucketWebsite",
      "s3:DeleteBucketWebsite",
      "s3:GetBucketVersioning",
      "s3:PutBucketVersioning",
      "s3:GetBucketPublicAccessBlock",
      "s3:PutBucketPublicAccessBlock",
      "s3:GetBucketEncryption",
      "s3:PutBucketEncryption",
      "s3:GetBucketRequestPayment",
      "s3:GetBucketLogging",
      "s3:PutBucketLogging",
      "s3:GetLifecycleConfiguration",
      "s3:PutLifecycleConfiguration",
      "s3:GetBucketReplication",
      "s3:PutBucketReplication",
      "s3:GetBucketTagging",
      "s3:PutBucketTagging",
      "s3:GetBucketOwnershipControls",
      "s3:PutBucketOwnershipControls",
      "s3:GetObjectLockConfiguration",
      "s3:PutObjectLockConfiguration"
    ]
    resources = [
      "arn:aws:s3:::prod-foundation-innovatefuture-prod-frontend-static",
    ]
  }
  statement {
    effect = "Allow"
    actions = [
      "s3:PutObject",
      "s3:GetObject",
      "s3:DeleteObject",
      "s3:ListMultipartUploadParts",
      "s3:AbortMultipartUpload",
      "s3:PutObjectAcl",
      "s3:GetObjectAcl",
      "s3:PutObjectTagging",
      "s3:GetObjectTagging",
      "s3:DeleteObjectTagging",
      "s3:PutObjectVersionTagging",
      "s3:GetObjectVersionTagging",
      "s3:DeleteObjectVersionTagging",
      "s3:GetObjectVersion",
      "s3:DeleteObjectVersion",
      "s3:ListMultipartUploads",
      "s3:GetObjectTorrent",
      "s3:GetObjectRetention",
      "s3:PutObjectRetention",
      "s3:GetObjectLegalHold",
      "s3:PutObjectLegalHold",
      "s3:RestoreObject",
      "s3:SelectObjectContent"
    ]
    resources = [
      "arn:aws:s3:::prod-foundation-innovatefuture-prod-frontend-static/*",
    ]
  }

  statement {
    effect = "Allow"
    actions = [
      "s3:ListAllMyBuckets",
      "s3:CreateBucket",
      "s3:DeleteBucket"
    ]
    resources = ["*"]
  }
}
