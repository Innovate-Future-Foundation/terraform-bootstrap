terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.1"
    }
  }
}

resource "aws_s3_bucket" "bkt" {
  bucket = var.bucket_name

  # Not sure if this is necessary

  # lifecycle {
  #   prevent_destroy = true
  # }
}

resource "aws_s3_bucket_versioning" "bkt" {
  bucket = aws_s3_bucket.bkt.id
  versioning_configuration {
    status = var.versioning
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "bkt" {
  bucket = aws_s3_bucket.bkt.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "bkt" {
  bucket = aws_s3_bucket.bkt.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

data "aws_iam_policy_document" "bkt_policy" {
  statement {
    effect = "Allow"
    principals {
      type        = "AWS"
      identifiers = [var.principal_role.arn]
    }
    actions = [
      "s3:ListBucket",
      "s3:GetObject",
      "s3:PutObject"
    ]
    resources = [aws_s3_bucket.bkt.arn, "${aws_s3_bucket.bkt.arn}/*"]
  }
}

resource "aws_s3_bucket_policy" "bkt" {
  bucket = aws_s3_bucket.bkt.id
  policy = data.aws_iam_policy_document.bkt_policy.json
}
