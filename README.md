# Terraform Infrastructure

This repository contains Terraform configurations for infrastructure as code.

## Table of Contents

- [Directory Structure](#directory-structure)
- [Creating & Using Modules](#creating--using-modules)
- [Deploying Terraform code](#deploying-terraform-code)


## Directory Structure

The directory structure is integral to the proper functioning of the Terraform configurations setup.


* [modules/](./modules)
  * [app_name/](./modules/web-app)
    * [main.tf](./modules/web-app/main.tf)
    * [variables.tf](./modules/web-app/variables.tf)
* [projects/](./projects)
  * [app_name/](./projects/web-app)
    * [main.tf](./projects/web-app/main.tf)
    * [Makefile](./projects/web-app/Makefile)
    * [provider.tf](./projects/web-app/provider.tf)
    * [variables.tf](./projects/web-app/variables.tf)
* [scripts/](./scripts/)




- `/modules`: Contains reusable Terraform modules. These are generic blueprints to create infrastructure components.
- `/projects`: Contains specific environments/projects like `staging`. 
- `/scripts`: Contains scripts those will help automate tasks. 


It's paramount to maintain this directory structure for the seamless operation and Terraform executions.

NOTE: Terraform states are stored locally.

## Creating & Using Modules
   

 **Create a reusable  Terraform module**:

   - Under `/modules`, create a new directory and naming it accordingly, e.g., `web-app`.
   - Then transcribe desired module following the same format as in `main.tf`. Steer away from using hardcoded values and follow `main.tf`, `output.tf`, `varibles.tf` file structure. Feel free to add more files if needed.
   
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
    

## Deploying Terraform code
    
  - When the code is ready, we can use Makefile to plan and apply Terraform code

  1. In order to terraform plan, run `make plan`. You should expect an output with similar format from below

    ```hcl
      Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
    + create

  Terraform will perform the following actions:

    # module.main.aws_instance.web_server will be created
    + resource "aws_instance" "web_server" {
        + ami                                  = "ami-0588935a949f9ff17"
        + arn                                  = (known after apply)
        + associate_public_ip_address          = (known after apply)
        + availability_zone                    = (known after apply)
        + cpu_core_count                       = (known after apply)
        + cpu_threads_per_core                 = (known after apply)
        + disable_api_stop                     = (known after apply)
        + disable_api_termination              = (known after apply)
        + ebs_optimized                        = (known after apply)
        + get_password_data                    = false
        + host_id                              = (known after apply)
        + host_resource_group_arn              = (known after apply)
        + iam_instance_profile                 = (known after apply)
        + id                                   = (known after apply)
        + instance_initiated_shutdown_behavior = (known after apply)
        + instance_lifecycle                   = (known after apply)
        + instance_state                       = (known after apply)
        + instance_type                        = "t2.micro"
        + ipv6_address_count                   = (known after apply)
        + ipv6_addresses                       = (known after apply)
        + key_name                             = "git.pub"
        + monitoring                           = (known after apply)
        + outpost_arn                          = (known after apply)
        + password_data                        = (known after apply)
        + placement_group                      = (known after apply)
        + placement_partition_number           = (known after apply)
        + primary_network_interface_id         = (known after apply)
        + private_dns                          = (known after apply)
        + private_ip                           = (known after apply)
        + public_dns                           = (known after apply)
        + public_ip                            = (known after apply)
        + secondary_private_ips                = (known after apply)
        + security_groups                      = (known after apply)
        + source_dest_check                    = true
        + spot_instance_request_id             = (known after apply)
        + subnet_id                            = (known after apply)
        + tags                                 = {
            + "ManagedBy" = "terraform"
          }
        + tags_all                             = {
            + "ManagedBy" = "terraform"
          }
        + tenancy                              = (known after apply)
        + user_data                            = "6ee99e1e80c5c3d7b9d70a4b2dded6e13a5497e5"
        + user_data_base64                     = (known after apply)
        + user_data_replace_on_change          = false
        + vpc_security_group_ids               = (known after apply)
      }

    # module.main.aws_key_pair.ssh_key will be created
    + resource "aws_key_pair" "ssh_key" {
        + arn             = (known after apply)
        + fingerprint     = (known after apply)
        + id              = (known after apply)
        + key_name        = "git.pub"
        + key_name_prefix = (known after apply)
        + key_pair_id     = (known after apply)
        + key_type        = (known after apply)
        + public_key      = "rsa-sdjajsdjadj"
        + tags_all        = (known after apply)
      }

    # module.main.aws_security_group.web_server_sg will be created
    + resource "aws_security_group" "web_server_sg" {
        + arn                    = (known after apply)
        + description            = "web-app sg"
        + egress                 = [
            + {
                + cidr_blocks      = [
                    + "0.0.0.0/0",
                  ]
                + description      = "allow-internet access"
                + from_port        = 0
                + ipv6_cidr_blocks = []
                + prefix_list_ids  = []
                + protocol         = "-1"
                + security_groups  = []
                + self             = false
                + to_port          = 0
              },
          ]
        + id                     = (known after apply)
        + ingress                = [
            + {
                + cidr_blocks      = [
                    + "73.51.96.210/32",
                  ]
                + description      = "web-app allow"
                + from_port        = 22
                + ipv6_cidr_blocks = []
                + prefix_list_ids  = []
                + protocol         = "tcp"
                + security_groups  = []
                + self             = false
                + to_port          = 22
              },
            + {
                + cidr_blocks      = [
                    + "73.51.96.210/32",
                  ]
                + description      = "web-app allow"
                + from_port        = 80
                + ipv6_cidr_blocks = []
                + prefix_list_ids  = []
                + protocol         = "tcp"
                + security_groups  = []
                + self             = false
                + to_port          = 80
              },
          ]
        + name                   = (known after apply)
        + name_prefix            = "web-app"
        + owner_id               = (known after apply)
        + revoke_rules_on_delete = false
        + tags                   = {
            + "ManagedBy" = "terraform"
          }
        + tags_all               = {
            + "ManagedBy" = "terraform"
          }
        + vpc_id                 = (known after apply)
      }

  Plan: 3 to add, 0 to change, 0 to destroy.





- After reviewing carefully, if the plan reflect the changes you ought to make, you can go ahead and run `make apply`

2. In case you want to delete the applied changes, you can run `make destroy`. However, before detroying make sure the resources do not contain any production data or services.

