# web-app deployment Terraform module

## What will this module do?

This module will deploy following resources:
1. Upload a SSH key to AWS EC2 Key Pairs. Lines 10-13.
2. A security group with ingress(inbound) and egress(outbound) rules. Lines 15-43.
3. An EC2 Server with SSH Key uploaded from point 1 and attached security group from point 3. This instance is launched using AMI retrieved from dta function. Lines 46-60.

## How to use Data function 

In this Module, ` data "aws_ami" "latest" `, lines 1-8,  function is used to retrieve AMI dynamically from AWS console. For more information how to use the data function refere to [Terraform data function doc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami)


Run following to get list of AMI based off name and Image ID. For more details refer to [Official AWS CLI doc](https://docs.aws.amazon.com/cli/latest/reference/ec2/describe-images.html)

- ` aws ec2 describe-images --owners amazon --query 'Images[*].[Name,ImageId]' --output text `

Run following command to get list of AMI based off a specific name. Replace AMI_NAME bu a value. For example `amzn2-ami-hvm-*`. For more details refer to [Official AWS CLI doc](https://docs.aws.amazon.com/cli/latest/reference/ec2/describe-images.html)

- ` aws ec2 describe-images --owners amazon --filters "Name=name,Values=AMI_NAME" --query 'Images[*].[Name,ImageId]' --output text`

## How to generate a key

In the home directory of the repository, there is a `scripts/` directory. In this directoyry, there is a script that will generate a 2048 bit RSA ssh key pair. When running the script, you will be prompted to input name and desired location of key pair.

- Usage ` ./ssh-keygen.sh`


## How to use Dynamic block for security group creation.

For more information refer to [official terraform doc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group)


   Here is the example of how it should look:

    ```hcl
    ### /modules/web-app/main.tf
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
      }
    

