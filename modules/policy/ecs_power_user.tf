data "aws_iam_policy_document" "ecs_poweruser" {
  statement {
    effect = "Allow"
    actions = [
      "ecs:TagResource",
      "ecs:CreateCluster",
      "ecs:DeleteService",
      "ecs:DeleteCluster",
      "ecs:DescribeTaskDefinition",
      "ecs:DescribeClusters",
      "ecs:ListServices",
      "ecs:DeregisterTaskDefinition",
      "ecs:UpdateService",
      "ecs:CreateService",
      "ecs:RegisterTaskDefinition",
      "ecs:DescribeServices",
      "ecs:ListTaskDefinitions",
      "ecs:ListClusters",
    ]
    resources = ["*"]
  }
}

resource "aws_iam_policy" "ecs_poweruser_policy" {
  name        = "ECSPowerUserPolicy"
  description = "Custom policy for managing ECS resources"
  policy      = data.aws_iam_policy_document.ecs_poweruser.json
}
