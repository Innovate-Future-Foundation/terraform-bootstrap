output "bucket_name" {
  value = aws_s3_bucket.bkt.bucket
}

output "bucket_arn" {
  value = aws_s3_bucket.bkt.arn
}