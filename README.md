# Threat Composer App
This application is a visual modelling tool which helps security professionals create threat models for applications and systems running on AWS, making it easier to identify, understand and mitigate potential security threats early on in the development lifecycle.

## Architecture Diagram

![alt text](<architecture.png>)

## Pre-requisites
- AWS account.
- GitHub installed and configured locally.
- Terraform installed locally.
- AWS Access Keys
- Cloudflare zoneID and API Token

## Project Structure

```

├── app/
├── terraform/
    └── main.tf
    └── providers.tf
    └── terraform.tfvars
    └── variables.tf
    └── modules
        └── acm/
            └── main.tf
            └── outputs.tf
            └── providers.tf
            └── variables.tf
        └── alb/
            └── main.tf
            └── outputs.tf
            └── providers.tf
            └── variables.tf
        └── domain/
            └── main.tf
            └── providers.tf
            └── variables.tf
        └── ecs/
            └── main.tf
            └── providers.tf
            └── variables.tf
        └── iam_role/
            └── main.tf
            └── outputs.tf
            └── providers.tf
        └── vpc/ 
            └── main.tf
            └── outputs.tf
            └── providers.tf
├── dockerfile
├── .github/workflows/
    └── build-and-push.yaml
└── README.md 

```

## Installation
1. Create a repository on GitHub and clone it locally.
```
git clone https://github.com/.../example-repo.git
```

2. Change directories into your repository directory.
```
cd example-repo
```

3. Clone this repository.
```
git clone https://github.com/riajul-98/ECS-thread-composer-app.git
```

4. Create your ECR repository on AWS.

5. Create GitHub Actions secrets that contain your AWS ECR Registry, your AWS Access Key and AWS Secret Access Key.

6. Push the code to GitHub using the below;

```
git add *filenames*
git commit -m "message here"
git push
```
Your repository should automatically start the pipeline and push it to your ECR registry.

7. Once successfully pushed, add your AWS access keys and Cloudflare API token as environment variables.
```
export AWS_ACCESS_KEY="access_key_here"
export AWS_SECRET_ACCESS_KEY="secret_access_key_here"
export CLOUDFLARE_API_TOKEN="API_token_here"
```

8. Change the bucket name to your bucket name in `./terraform/providers.tf` and create a .tfvars file which contains the below;
```
domain_name     = 
zone_id         = 
container_image = 
ecs_port        = 
subdomain       = 
ecs_launch_type = 
desired_number  = 
number_of_cpu   = 
mem             = 

```

9. Deploy your infrastructure.
```
terraform init
terraform plan
terraform apply
```

10. Check if the application has deployed by typing in https://tm.<domain_name> in your browser. You should see the below;

![alt text](<threat_composer.png>)

## Potential issues
1. Pipeline failing to build - Could be due to many issues, check failure message.
2. ECS tasks not being able to pull the image - You may already have an IAM role with the same name which does not contain the correct permissions.
3. Terraform failing to build - User tied to the access keys may not have the correct permissions for the specific services / resources.
4. Terraform hanging at the ACM request stage - Cancel the command using `ctrl + c` and then running another `terraform apply`.