resource "aws_instance" "web_server" {
  depends_on = [
    aws_key_pair.ssh_key, aws_security_group.web_server_sg
  ]
  ami             = data.aws_ami.latest.id
  instance_type   = var.instance_type
  key_name        = aws_key_pair.ssh_key.key_name
  security_groups = [aws_security_group.web_server_sg.name]
  tags            = var.tags

  user_data = var.user_data
  
#   lifecycle {
#     prevent_destroy = true
#  }
}

data "aws_ami" "latest" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*"] 
  }
}

resource "aws_security_group" "web_server_sg" {
  name_prefix = var.sg_name
  description = var.sg_description
  tags = var.tags

  # Ingress rules
  dynamic "ingress" {
    for_each = var.ingress_rules
     content {
          description = ingress.value["ingress_description"]
          from_port   = ingress.value["ingress_from_port"]
          to_port     = ingress.value["ingress_to_port"]
          protocol    = ingress.value["ingress_protocol"]
          cidr_blocks = ingress.value["ingress_cidr_blocks"]
        }
  }


  # Egress rules
  dynamic "egress" {
    for_each = var.egress_rules
      content {
          description = egress.value["egress_description"]
          from_port   = egress.value["egress_from_port"]
          to_port     = egress.value["egress_to_port"]
          protocol    = egress.value["egress_protocol"]
          cidr_blocks = egress.value["egress_cidr_blocks"]
        }
      }
}

resource "aws_key_pair" "ssh_key" {
  key_name   = var.key_name
  public_key = file(var.public_key_path) 
}