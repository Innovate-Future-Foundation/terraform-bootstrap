terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.1"
    }
  }
}

data "aws_caller_identity" "current" {}

locals {
  # Transform the input policy ARNs into the required format
  custom_policy_arns = {
    FrontendS3Policy           = aws_iam_policy.s3_custom_policy.arn
    FrontendBucketConfigPolicy = aws_iam_policy.bucket_config_policy.arn
    FrontendCloudFrontPolicy   = aws_iam_policy.cloudfront_custom_policy.arn
    FrontendRoute53AcmPolicy   = aws_iam_policy.route53_acm_policy.arn
  }
}

# 1. S3 Bucket Policy
resource "aws_iam_policy" "s3_custom_policy" {
  name        = "FrontendS3BucketPolicy"
  description = "Policy for managing frontend S3 bucket"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "s3:CreateBucket",
          "s3:DeleteBucket",
          "s3:ListBucket",
          "s3:GetBucketLocation",
          "s3:GetBucketPolicy",
          "s3:PutBucketPolicy",
          "s3:GetBucketAcl",
        ]
        Resource = "arn:aws:s3:::*"
      },
      {
        Effect = "Allow"
        Action = [
          "s3:PutObject",
          "s3:GetObject",
          "s3:DeleteObject",
          "s3:ListBucketMultipartUploads",
          "s3:ListMultipartUploadParts",
        ]
        Resource = "arn:aws:s3:::*/*"
      }
    ]
  })
}

# 2. Bucket Configuration Policy
resource "aws_iam_policy" "bucket_config_policy" {
  name        = "FrontendBucketConfigPolicy"
  description = "Policy for managing frontend bucket configurations"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "s3:PutBucketVersioning",
          "s3:GetBucketVersioning",
          "s3:PutBucketCORS",
          "s3:GetBucketCORS",
          "s3:PutBucketPublicAccessBlock",
          "s3:GetBucketPublicAccessBlock",
          "s3:PutEncryptionConfiguration",
          "s3:GetEncryptionConfiguration",
        ]
        Resource = "arn:aws:s3:::*"
      }
    ]
  })
}

# 3. CloudFront Policy
resource "aws_iam_policy" "cloudfront_custom_policy" {
  name        = "FrontendCloudFrontPolicy"
  description = "Policy for managing frontend CloudFront distribution"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "cloudfront:CreateDistribution",
          "cloudfront:DeleteDistribution",
          "cloudfront:GetDistribution",
          "cloudfront:UpdateDistribution",
          "cloudfront:TagResource",
          "cloudfront:CreateInvalidation",
          "cloudfront:GetInvalidation",
          "cloudfront:ListCachePolicies",
          "cloudfront:GetCachePolicy",
          "cloudfront:ListResponseHeadersPolicies",
          "cloudfront:GetResponseHeadersPolicy",
          "cloudfront:CreateOriginAccessControl",
          "cloudfront:GetOriginAccessControl",
          "cloudfront:DeleteOriginAccessControl",
        ]
        Resource = "*"
      },
      {
        Effect = "Allow"
        Action = [
          "cloudfront:CreateOriginAccessIdentity",
          "cloudfront:DeleteOriginAccessIdentity",
          "cloudfront:GetOriginAccessIdentity",
        ]
        Resource = "arn:aws:cloudfront::*:origin-access-identity/*"
      }
    ]
  })
}

# 4. Route53 & ACM Policy
resource "aws_iam_policy" "route53_acm_policy" {
  name        = "FrontendRoute53AcmPolicy"
  description = "Policy for managing frontend DNS and certificates"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "route53:ListHostedZones",
          "route53:ChangeResourceRecordSets",
          "route53:GetChange",
          "route53:GetHostedZone",
          "route53:ListResourceRecordSets",
          "route53:ListTagsForResource",
        ]
        Resource = [
          "*"
        ]
      },
      {
        Effect = "Allow"
        Action = [
          "acm:RequestCertificate",
          "acm:DescribeCertificate",
          "acm:DeleteCertificate",
          "acm:ListCertificates",
          "acm:AddTagsToCertificate",
          "acm:ListTagsForCertificate",
        ]
        Resource = "arn:aws:acm:*:*:certificate/*"
      }
    ]
  })
}
