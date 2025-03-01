locals {
  central_ecr_repo_arn = "arn:aws:ecr:${var.central_ecr_region}:${var.prod_account_id}:repository/${var.central_ecr_repo}"
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
