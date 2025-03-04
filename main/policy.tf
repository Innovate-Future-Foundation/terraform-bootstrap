locals {
  uat_custom_policy_arns = {
    CentralECRTaggingPolicy    = aws_iam_policy.uat_central_ecr_tagging_policy.arn
    CentralECRPublishingPolicy = aws_iam_policy.uat_central_ecr_publishing_policy.arn
    UATFrontendS3Policy        = aws_iam_policy.UATFrontendS3Policy.arn
  }
  prod_custom_policy_arns = {
    CentralECRTaggingPolicy = aws_iam_policy.prod_central_ecr_tagging_policy.arn
    ProdFrontendS3Policy    = aws_iam_policy.ProdFrontendS3Policy.arn
  }
  sso_custom_policy_arns = {
    SSOManagementPowerUserPolicy = aws_iam_policy.sso_management_poweruser_policy.arn
  }
}

# Additional Policies for UAT environment/account
resource "aws_iam_policy" "uat_central_ecr_tagging_policy" {
  provider    = aws.uat_account
  name        = "CentralECRTaggingPolicy"
  description = "Allows tagging images in the central ECR"
  policy      = data.aws_iam_policy_document.central_ecr_tagging_policy.json
}

resource "aws_iam_policy" "uat_central_ecr_publishing_policy" {
  provider    = aws.uat_account
  name        = "CentralECRPublishingPolicy"
  description = "Allows tagging and pushing images to the central ECR"
  policy      = data.aws_iam_policy_document.central_ecr_publishing_policy.json
}

resource "aws_iam_policy" "UATFrontendS3Policy" {
  provider    = aws.uat_account
  name        = "UATFrontendS3Policy"
  description = "Custom policy for managing frontend S3 buckets and objects in UAT environment"
  policy      = data.aws_iam_policy_document.uat_frontend_s3_poweruser_policy.json
}

# Additional Policies for Production environment/account
resource "aws_iam_policy" "prod_central_ecr_tagging_policy" {
  provider    = aws.production_account
  name        = "CentralECRTaggingPolicy"
  description = "Allows tagging images in the central ECR"
  policy      = data.aws_iam_policy_document.central_ecr_tagging_policy.json
}

resource "aws_iam_policy" "ProdFrontendS3Policy" {
  provider    = aws.production_account
  name        = "ProdFrontendS3Policy"
  description = "Custom policy for managing frontend S3 buckets and objects in Prod environment"
  policy      = data.aws_iam_policy_document.prod_frontend_s3_poweruser_policy.json
}

# Additional Policies for SSO Management account
resource "aws_iam_policy" "sso_management_poweruser_policy" {
  provider    = aws.sso_account
  name        = "SSOManagementPowerUserPolicy"
  description = "SSO Adminstrative policy for managing Organisation SSO Users"
  policy      = data.aws_iam_policy_document.sso_management_poweruser_policy.json
}
