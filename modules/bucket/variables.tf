variable "bucket_name" {
  type = string
}

variable "principal_role" {
  type = object({
    arn = string
  })
}