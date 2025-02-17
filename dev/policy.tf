locals {
  # Transform the input policy ARNs into the required format
  custom_policy_arns = {
    DevFrontendS3Policy = aws_iam_policy.s3_frontend_power_user_policy.arn
  }
}

# S3 Frontend Power User Policy for Dev Environment
data "aws_iam_policy_document" "s3_frontend_power_user" {
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
      "arn:aws:s3:::dev-foundation-innovatefuture-dev-frontend-static",
      "arn:aws:s3:::pr-preview-*"
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
      "arn:aws:s3:::dev-foundation-innovatefuture-dev-frontend-static/*",
      "arn:aws:s3:::pr-preview-*/*"
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

resource "aws_iam_policy" "s3_frontend_power_user_policy" {
  name        = "DevFrontendS3Policy"
  description = "Custom policy for managing frontend S3 buckets and objects in Dev environment"
  policy      = data.aws_iam_policy_document.s3_frontend_power_user.json
}

# Your Environment Specific Custom Policies

# resource "aws_iam_policy" "custom_policy" {
#   provider    = aws
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
