data "aws_iam_policy_document" "role_management_policy" {
  version = "2012-10-17"
  statement {
    sid    = "AllowRoleManagement"
    effect = "Allow"
    actions = [
      "iam:CreateRole",
      "iam:DeleteRole",
      "iam:TagRole",
      "iam:PassRole",
      "iam:UntagRole",
      "iam:GetRole",
      "iam:ListRoles",
      "iam:UpdateRole",
      "iam:AttachRolePolicy",
      "iam:DetachRolePolicy",
      "iam:PutRolePolicy",
      "iam:DeleteRolePolicy",
      "iam:ListRolePolicies",
      "iam:ListAttachedRolePolicies",
      "iam:ListInstanceProfilesForRole",
      "iam:GetRolePolicy"
    ]
    resources = ["*"]
  }
}

resource "aws_iam_policy" "dev_role_management_policy" {
  name        = "RoleManagementPolicy"
  description = "Custom policy for managing roles"
  policy      = data.aws_iam_policy_document.role_management_policy.json
}
