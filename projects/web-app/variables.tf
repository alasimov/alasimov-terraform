# Common variables
variable "aws_region" {
    type = string
    default = "us-east-1"
}
variable "tags" {
  type = object({
    ManagedBy   = string
  })
  default = {
    ManagedBy   = "terraform"
  }
}