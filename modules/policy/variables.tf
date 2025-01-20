variable "tags" {
  description = "Resource tags"
  type        = map(string)
  default     = {}
}
variable "frontend_bucket_name" {
  description = "Name of the frontend S3 bucket"
  type        = string
}

variable "hosted_zone_id" {
  description = "Route53 hosted zone ID"
  type        = string
}