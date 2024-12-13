variable "bucket_name" {
  type = string
}

variable "principal_role" {
  type = object({
    arn = string
  })
}

variable "lifecycle_expiration_days" {
  type    = number
  default = 30
}