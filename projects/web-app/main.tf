module "main" {
    source = "../../modules/web-app"


    tags = merge(var.tags, {
      Name = "web-app"
    })

    # EC2 values
    instance_type = "t2.micro"
    user_data = <<-EOF
              #!/bin/bash
              # Install Apache web server
              yum update -y
              sudo amazon-linux-extras install -y nginx1
              systemctl enable nginx
              systemctl start nginx
              echo "<html><body><h1>Hello World, This is Al's terraform project</h1></body></html>" > /usr/share/nginx/html/index.html
              EOF



    # Security group values
    sg_name = "web-app"
    sg_description = "web-app sg"
    

    ingress_rules = {
      allow-http = {
        ingress_description = "web-app allow http"
        ingress_from_port   = 80
        ingress_to_port     = 80
        ingress_protocol    = "tcp"
        ingress_cidr_blocks = ["52.89.129.181/32", "66.37.42.0/24", "147.30.167.248/32"] 
      },
      allow-https = {
        ingress_description = "web-app allow https from Local, provisioner instance"
        ingress_from_port   = 443
        ingress_to_port     = 443
        ingress_protocol    = "tcp"
        ingress_cidr_blocks = ["52.89.129.181/32", "147.30.167.248/32"] #my ip and ec2 IP, 
      },
      allow-ssh = {
        ingress_description = "web-app allow ssh provisioner instance"
        ingress_from_port   = 22
        ingress_to_port     = 22
        ingress_protocol    = "tcp"
        ingress_cidr_blocks = ["52.89.129.181/32"] 
      },
    }

    egress_rules = {
      all-access = { 
        egress_description = "allow-internet access"
        egress_from_port   = 0
        egress_to_port     = 0
        egress_protocol    = "-1"
        egress_cidr_blocks = ["0.0.0.0/0"]
      }
    }

    # ssh key values
      key_name = "web-app.pub"
      public_key_path = "~/.ssh/web-app.pub"
    }