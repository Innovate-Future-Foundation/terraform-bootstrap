variable "bucket_name" {
  type = string
}

variable "principal_role" {
  type = object({
    arn = string
  })
}

variable "versioning" {
  type    = string
  default = "Enabled"
}

variable "plan_file_expiration_days" {
  type    = number
  default = 30
}
