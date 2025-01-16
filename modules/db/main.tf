resource "aws_dynamodb_table" "state_locks" {
  name         = var.table_name
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = var.hash_key

  attribute {
    name = var.hash_key
    type = "S"
  }

  # Not sure if this is necessary

  # lifecycle {
  #   prevent_destroy = true
  # }
}

data "aws_iam_policy_document" "state_locks" {
  statement {
    sid    = "TerraformStateLockAccess"
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["${var.principal_role.arn}"]
    }

    actions = [
      "dynamodb:GetItem",
      "dynamodb:PutItem",
      "dynamodb:DeleteItem"
    ]

    resources = [
      "${aws_dynamodb_table.state_locks.arn}"
    ]
  }
}

resource "aws_dynamodb_resource_policy" "state_locks" {
  resource_arn = aws_dynamodb_table.state_locks.arn
  policy       = data.aws_iam_policy_document.state_locks.json
}
