data "aws_iam_policy_document" "ecr_poweruser" {
  statement {
    effect = "Allow"
    actions = [
      "ecr:CreateRepository",
      "ecr:DeleteRepository",
      "ecr:DescribeRepositories",
      "ecr:ListRepositories",
      "ecr:TagResource",
      "ecr:ListTagsForResource",
      "ecr:PutImageTagMutability",
      "ecr:PutImageScanningConfiguration",
      "ecr:GetRepositoryPolicy",
      "ecr:SetRepositoryPolicy",
      "ecr:DeleteRepositoryPolicy",
      "ecr:GetLifecyclePolicy",
      "ecr:PutLifecyclePolicy",
      "ecr:DeleteLifecyclePolicy"
    ]
    resources = ["*"]
  }
}

resource "aws_iam_policy" "ecr_poweruser_policy" {
  name        = "ECRPowerUserPolicy"
  description = "Custom policy for managing ECR repositories"
  policy      = data.aws_iam_policy_document.ecr_poweruser.json
}
