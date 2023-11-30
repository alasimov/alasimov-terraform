# Terraform Infrastructure

This repository contains Terraform configurations for infrastructure as code.

## Table of Contents

- [Directory Structure](#directory-structure)
- [Creating & Using Modules](#creating--using-modules)
- [Deploying Terraform code](#deploying-terraform-code)


## Directory Structure

The directory structure is integral to the proper functioning of the Terraform configurations setup.

# terraform-infrastructure

* [modules/](./terraform-infrastructure/modules)
  * [app_name/](./terraform-infrastructure/modules/ec2)
    * [main.tf](./terraform-infrastructure/ec2/main.tf)
    * [variables.tf](./terraform-infrastructure/modules/ec2/variables.tf)
* [projects/](./terraform-infrastructure//projects)
  * [app_name/](./terraform-infrastructure//projects/ec2-app)
    * [main.tf](./terraform-infrastructure//projects/ec2-app/main.tf)
    * [Makefile](./terraform-infrastructure//projects/ec2-app/Makefile)
    * [provider.tf](./terraform-infrastacture/projects/project-name/provider.tf)
    * [variables.tf](./terraform-infrastructure/modules/ec2/variables.tf)




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
    
  - When the code is ready, we can test the code using dry-run