resource "aws_instance" "web_server" {
  depends_on = [
    aws_key_pair.ssh_key, aws_security_group.web_server
  ]
  ami             = data.aws_ami.latest.id
  instance_type   = var.instance_type
  key_name        = aws_key_pair.ssh_key.key_name
  security_groups = [aws_security_group.web_server_sg.name]
  tags            = var.tags

  user_data = var.user_data
  
  lifecycle {
    prevent_destroy = true
 }
}

data "aws_ami" "latest" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*"] # Filter for your desired Amazon Linux 2 AMI
  }
}


# <<-EOF
#               #!/bin/bash
#               # Install Apache web server
#               yum update -y
#               yum install -y httpd
#               systemctl enable httpd
#               systemctl start httpd
#               echo "Web server is up and running on \$(curl -s http://169.254.169.254/latest/meta-data/public-ipv4)" > /var/www/html/index.html
#               EOF