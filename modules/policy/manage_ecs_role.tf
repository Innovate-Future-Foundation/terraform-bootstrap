data "aws_iam_policy_document" "manage_ecs_role" {
  statement {
    effect = "Allow"
    actions = [
      "iam:PassRole",
    ]
    condition {
      test     = "StringLike"
      variable = "iam:PassedToService"
      values   = ["ecs-tasks.amazonaws.com"]
    }
    resources = ["arn:aws:iam::*:role/ecsTestTaskExecutionRole", ]
  }
  statement {
    effect    = "Allow"
    actions   = ["iam:ListEntitiesForPolicy"]
    resources = ["arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy", ]
  }
  statement {
    effect = "Allow"
    actions = [
      "iam:CreateRole",
      "iam:GetRole",
      "iam:ListRolePolicies",
      "iam:ListAttachedRolePolicies",
      "iam:ListInstanceProfilesForRole",
      "iam:AttachRolePolicy",
      "iam:TagRole",
      "iam:UntagRole",
      "iam:DeleteRole",
      "iam:DetachRolePolicy",
    ]
    resources = ["arn:aws:iam::*:role/ecsTestTaskExecutionRole"]
  }
}

resource "aws_iam_policy" "manage_ecs_role_policy" {
  name        = "ManageECSRolePolicy"
  description = "Custom policy for managing ECS Task role"
  policy      = data.aws_iam_policy_document.manage_ecs_role.json
}
