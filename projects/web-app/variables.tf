# Common variables
variable "aws_region" {
    type = string
    default = "us-west-2"
}
variable "tags" {
  type = object({
    ManagedBy   = string
  })
  default = {
    ManagedBy   = "terraform"
  }
}