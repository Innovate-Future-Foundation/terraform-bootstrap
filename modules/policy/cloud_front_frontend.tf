data "aws_iam_policy_document" "cloudfront_power_user" {
  statement {
    effect = "Allow"
    actions = [
      "cloudfront:CreateDistribution",
      "cloudfront:DeleteDistribution",
      "cloudfront:GetDistribution",
      "cloudfront:GetDistributionConfig",
      "cloudfront:UpdateDistribution",
      "cloudfront:ListDistributions",
      "cloudfront:ListDistributionsByWebACLId",
      "cloudfront:CreateInvalidation",
      "cloudfront:GetInvalidation",
      "cloudfront:ListInvalidations",
      "cloudfront:TagResource",
      "cloudfront:UntagResource",
      "cloudfront:ListTagsForResource",
      "cloudfront:GetCachePolicy",
      "cloudfront:ListCachePolicies",
      "cloudfront:CreateOriginAccessControl",
      "cloudfront:GetOriginAccessControl",
      "cloudfront:ListOriginAccessControls",
      "cloudfront:DeleteOriginAccessControl",
      "cloudfront:UpdateOriginAccessControl",
      "cloudfront:GetResponseHeadersPolicy",
      "cloudfront:ListResponseHeadersPolicies",
      "cloudfront:GetFieldLevelEncryptionConfig",
      "cloudfront:GetFieldLevelEncryptionProfile",
      "cloudfront:ListFieldLevelEncryptionConfigs",
      "cloudfront:ListFieldLevelEncryptionProfiles",
      "cloudfront:GetPublicKey",
      "cloudfront:ListPublicKeys",
      "cloudfront:GetRealtimeLogConfig",
      "cloudfront:ListRealtimeLogConfigs",
      "cloudfront:GetMonitoringSubscription",
      "cloudfront:GetContinuousDeploymentPolicy",
      "cloudfront:ListContinuousDeploymentPolicies",
      "cloudfront:CreateFunction",
      "cloudfront:GetFunction",
      "cloudfront:ListFunctions",
      "cloudfront:UpdateFunction",
      "cloudfront:DeleteFunction",
      "cloudfront:PublishFunction",
      "cloudfront:TestFunction",
    ]
    resources = ["*"]
  }
}

resource "aws_iam_policy" "cloudfront_power_user_policy" {
  name        = "CloudFrontPowerUserPolicy"
  description = "Custom policy for managing CloudFront distributions"
  policy      = data.aws_iam_policy_document.cloudfront_power_user.json
}