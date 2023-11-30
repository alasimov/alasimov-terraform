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
          description = ingress.value["egress_description"]
          from_port   = ingress.value["egress_from_port"]
          to_port     = ingress.value["egress_to_port"]
          protocol    = ingress.value["egress_protocol"]
          cidr_blocks = ingress.value["egress_cidr_blocks"]
        }
      }
}


