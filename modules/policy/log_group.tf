data "aws_iam_policy_document" "log_group_inff_user" {
  statement {
    effect = "Allow"
    actions = [
      "logs:CreateLogGroup",
      "logs:DeleteLogGroup",
      "logs:TagResource",
      "logs:UntagResource",
      "logs:ListTagsForResource",
      "logs:PutRetentionPolicy",
      "logs:DescribeLogGroups",
    ]
    resources = ["arn:aws:logs:*:*:log-group:inff/*"]
  }
  statement {
    effect    = "Allow"
    actions   = ["logs:DescribeLogGroups"]
    resources = ["arn:aws:logs:*:*:log-group:*"]
  }
  statement {
    effect = "Allow"
    actions = [
      "logs:CreateLogDelivery",
      "logs:ListLogDeliveries",
    ]
    resources = ["*"]
  }
}

resource "aws_iam_policy" "log_group_inff_user_policy" {
  name        = "LogGroupInFFUserPolicy"
  description = "Custom policy for managing InFF Log Groups resources"
  policy      = data.aws_iam_policy_document.log_group_inff_user.json
}
