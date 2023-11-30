# Terraform Infrastructure with GitLab CI

This repository contains Terraform configurations managed with GitLab CI for infrastructure as code.

## Table of Contents

- [Directory Structure](#directory-structure)
- [Creating & Using Modules](#creating--using-modules)
- [Adding a New Project](#adding-a-new-project)
- [Creating CI Configuration for a New Project](#creating-ci-configuration-for-a-new-project)

## Directory Structure

The directory structure is integral to the proper functioning of the Terraform configurations and GitLab CI setup.

# terraform-infra

* [_ci/](./terraform-infra/_ci)
  * [gcp-project.yaml](./terraform-infra/_ci/gcp-project.yaml)
* [modules/](./terraform-infra/modules)
  * [cloud_resource_name/](./terraform-infra/modules/resource_name)
    * [main.tf](./terraform-infra/modules/resource_name/main.tf)
    * [variables.tf](./terraform-infra/modules/resource_name/variables.tf)
* [projects/](./terraform-infra/projects)
  * [project-name/](./terraform-infra/projects/project-name)
    * [backend.tf](./terraform-infra/projects/project-name/backend.tf)
    * [env.tf](./terraform-infra/projects/project-name/env.tf)
    * [output.tf](./terraform-infra/projects/project-name/output.tf)
    * [provider.tf](./terraform-infra/projects/project-name/provider.tf)
* [.gitlab-ci.yml](./terraform-infra/.gitlab-ci.yml)


- `/_ci`: Contains environment-specific CI configurations like `porch-dev.yaml`. Each environment (porch-dev, porch-qa, porch-prod, etc.) should have its own configuration.
- `/modules`: Contains reusable Terraform modules. These are generic blueprints to create infrastructure components.
- `/projects`: Specific environments/projects like `porch-dev`. Each project refers to modules and adds specifics like project_id, region, etc.
- `.gitlab_ci.yaml`: Main CI configuration file.


It's paramount to maintain this directory structure for the seamless operation of the CI/CD process and Terraform executions.

NOTE: Terraform states are stored in porch-mgmt in [porch-terraform-states](https://console.cloud.google.com/storage/browser/porch-terraform-states;tab=objects?forceOnBucketsSortingFiltering=true&project=porch-mgmt)

## Creating a GCP Projects, modules & using them.

1. **Create a GCP Project**:

   - Under `/projects`, create a new directory by copying `project-name/` directory and naming it accordingly, e.g., `porch-dev`.
   - Then rename all references of 'env' or 'ENV' to corresponding project name, in this case `porch-dev`, and follow commeted instructions and naming conventions.
   - When calling a module using "module" function make sure to name each module differently. No module name can be the same.
   
   
   After creating project directory we need to set up CI for the project

   - Under `_ci/`, create a new by copying `gcp-project.yaml` and name it accordingly, e.g., `porch-dev`.
   - In the CI configuration file, make sure to set all references of ENVIRONMENT/ENV/env to corresponding project name and replace "gcp_project" in job names as well.
   - Make adjustments to Terraform version and other configurations if necessary.
   - Ask the one of the Maintainers of the repository to generate a new [access key file](https://cloud.google.com/iam/docs/keys-create-delete)
 and save it in repository environment variables and change the variable name PORCH_SA_CREDENTIALS in `gcp-project.yaml` accordingly.

    Finally ask the maintainers of the repository to include `gcp-project.yaml` file you are working onto the `.gilab-ci.yml` file

   

2. **Create a Terraform module**:

   - Under `/modules`, create a new directory by copying `cloud_resource_name/` directory and naming it accordingly, e.g., `google_cloud_storage`.
   - Then transcribe desired module following the same format as in `main.tf`. Steer away from using hardcoded values and follow `main.tf`, `output.tf`, `varibles.tf` file structure. Feel free to add more files if needed.
   
   Here is the example of how it should look:

   ```hcl
   ### /modules/google_cloud_storage/main.tf
   resource "google_storage_bucket" "gcs_main" {
    name          = var.bucket_name
    location      = var.bucket_location
    storage_class = var.bucket_storage_class
    project       = var.project_id
    
    versioning {
        enabled = var.bucket_versioning
    }

    public_access_prevention = var.bucket_public_access_prevention
    }

    ### /projects/porch-dev/main.tf
    module "main" {
        source = "../../modules/google_cloud_storage"

        bucket_name                     = "test-bucket-porch-alex-helper"
        bucket_location                 = "us-east1"
        bucket_storage_class            = "STANDARD"
        project_id                      = "porch-dev"
        
        bucket_versioning               = false
        
        bucket_public_access_prevention = ""
    }

## How to run and test Terraform.

   - In order to run the code, we need to open a Merge Request.
   - Upon Opening merge request, Terraform validate and Terraform plan will run
   - Alway make sure to check the Plan job and make sure the outcome is what is expected.
   - After you have confirmed that Plan is indeed, what we want to achieve, we can request an approval from one of the team members. Job can be approved after Plan review by reviewer clears, they can approve the job in Deployments-->Environments. After the approval we can apply the Plan. 
