data "aws_iam_policy_document" "inff_secret_read" {
  statement {
    effect    = "Allow"
    actions   = ["secretsmanager:GetSecretValue"]
    resources = ["arn:aws:secretsmanager:*:*:secret:INFF_*"]
  }
}

resource "aws_iam_policy" "inff_secret_read_policy" {
  name        = "InFFSecretReadPolicy"
  description = "Access to Inff secret value"
  policy      = data.aws_iam_policy_document.inff_secret_read.json
}
