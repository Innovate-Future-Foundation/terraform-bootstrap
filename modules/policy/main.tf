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
    NetworkPowerUserPolicy     = aws_iam_policy.network_poweruser_policy.arn
    CloudMapPowerUserPolicy    = aws_iam_policy.cloud_map_poweruser_policy.arn
    ECRPowerUserPolicy         = aws_iam_policy.ecr_poweruser_policy.arn
    LogGroupInFFUserPolicy     = aws_iam_policy.log_group_inff_user_policy.arn
    ManageECSRolePolicy        = aws_iam_policy.manage_ecs_role_policy.arn
    ECSPowerUserPolicy         = aws_iam_policy.ecs_poweruser_policy.arn
    S3FrontendPowerUserPolicy  = aws_iam_policy.s3_frontend_power_user_policy.arn
    CloudFrontFrontendPowerUserPolicy  = aws_iam_policy.cloudfront_frontend_power_user_policy
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
          "s3:GetBucketWebsite",
          "s3:GetBucketRequestPayment",
          "s3:GetBucketLogging",
          "s3:GetLifecycleConfiguration",
          "s3:GetReplicationConfiguration",
          "s3:GetBucketObjectLockConfiguration",
          "s3:GetBucketTagging"
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
          "s3:ListMultipartUploadParts"
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
          "s3:GetEncryptionConfiguration"
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
          "cloudfront:ListTagsForResource"
        ]
        Resource = "*"
      },
      {
        Effect = "Allow"
        Action = [
          "cloudfront:CreateOriginAccessIdentity",
          "cloudfront:DeleteOriginAccessIdentity",
          "cloudfront:GetOriginAccessIdentity"
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
          "route53:ListTagsForResource"
        ]
        Resource = "*"
      },
      {
        Effect = "Allow"
        Action = [
          "acm:RequestCertificate",
          "acm:DescribeCertificate",
          "acm:DeleteCertificate",
          "acm:ListCertificates",
          "acm:AddTagsToCertificate",
          "acm:ListTagsForCertificate"
        ]
        Resource = "arn:aws:acm:*:*:certificate/*"
      }
    ]
  })
}

data "aws_iam_policy_document" "network_poweruser_policy" {
  statement {
    effect = "Allow"
    actions = [
      "ec2:CreateVpc",
      "ec2:DeleteVpc",
      "ec2:DescribeVpcs",
      "ec2:DescribeVpcAttribute",
      "ec2:DescribeNetworkInterfaces",
      "ec2:ModifyVpcAttribute",
      "ec2:CreateSubnet",
      "ec2:DeleteSubnet",
      "ec2:DescribeSubnets",
      "ec2:CreateInternetGateway",
      "ec2:DeleteInternetGateway",
      "ec2:AttachInternetGateway",
      "ec2:DetachInternetGateway",
      "ec2:DescribeInternetGateways",
      "ec2:CreateRouteTable",
      "ec2:DeleteRouteTable",
      "ec2:DescribeRouteTables",
      "ec2:CreateRoute",
      "ec2:DeleteRoute",
      "ec2:AssociateRouteTable",
      "ec2:DisassociateRouteTable",
      "ec2:CreateSecurityGroup",
      "ec2:DeleteSecurityGroup",
      "ec2:DescribeSecurityGroups",
      "ec2:AuthorizeSecurityGroupIngress",
      "ec2:RevokeSecurityGroupIngress",
      "ec2:AuthorizeSecurityGroupEgress",
      "ec2:RevokeSecurityGroupEgress",
      "ec2:CreateTags",
      "ec2:DeleteTags",
    ]
    resources = ["*"]
  }
}

resource "aws_iam_policy" "network_poweruser_policy" {
  name        = "NetworkPowerUserPolicy"
  description = "Custom policy for managing VPC Network resources"
  policy      = data.aws_iam_policy_document.network_poweruser_policy.json
}
