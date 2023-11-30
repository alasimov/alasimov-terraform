module "main" {
    source = "../../modules/web-app"
    
# EC2 values
instance_type = ""
user_data = ""

# Security group values
sg_name = ""
sg_description = ""

ingress_rules = {
  type = {
    ingress_description = ""
    ingress_from_port   = ""
    ingress_to_port     = 2
    ingress_protocol    = 2
    ingress_cidr_blocks = [""]
  }
}

egress_rules = {
   Name = { 
    egress_description = ""
    egress_from_port   = ""
    egress_to_port     = 1
    egress_protocol    = 1
    egress_cidr_blocks = [""]
   }
}

# ssh key values
  key_name = ""
  public_key_path = ""
    tags = merge(var.tags, {
    Name = "web-app"
  })
}