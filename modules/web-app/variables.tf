# Common variables
variable "tags" {
  type = object({
    Environment = string
    ManagedBy   = string
  })
  default = {
    ManagedBy   = "terraform"
  }
}
# EC2 variables
variable "instance_type" {
  description = "Instance type of the ec2 machine"
  type = string
}
variable "user_data" {
  description = "User data to be applied at the ec2 launch"
  type = string
}

# Security group varibles
variable "sg_name" {
  description = "Security group name"
  type = string
}
variable "sg_description" {
  description = "Security Group description"
  type = string
}

variable "ingress_rules" {
  default = {}
  type = map(object({
    ingress_description = string
    ingress_from_port   = number
    ingress_to_port     = number
    ingress_protocol    = string
    ingress_cidr_blocks = list(string)
  }))
}

variable "egress_rules" {
  default = {}
  type = map(object({
    egress_description = string
    egress_from_port   = number
    egress_to_port     = number
    egress_protocol    = string
    egress_cidr_blocks = list(string)
  })) 
}

# ssh key variables
variable "key_name" {
  description = "Name of the public key"
  type = string
}
variable "public_key_path" {
  description = "Path to the public key"
  type = string
}