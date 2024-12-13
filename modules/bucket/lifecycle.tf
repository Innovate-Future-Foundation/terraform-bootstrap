resource "aws_s3_bucket_lifecycle_configuration" "bkt_lifecycle" {
  bucket = aws_s3_bucket.bkt.id

  rule {
    id     = "cleanup-old-plan-files"
    status = "Enabled"

    filter {
      prefix = "plans/"
    }

    expiration {
      days = var.lifecycle_expiration_days
    }
  }
}