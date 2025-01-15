variable "table_name" {
  type = string
}

variable "hash_key" {
  type = string
  default = "LockID"
}

variable "principal_role" {
  type = object({
    arn = string
  })
}