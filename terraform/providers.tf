terraform {
  required_version = "1.9.8"
  required_providers {
    # Initialising AWS as a provider
    aws = {
      source  = "hashicorp/aws"
      version = "6.0.0-beta2"
    }

    # Initialising Cloudflare as a provider
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "5.5.0"
    }
  }

  # Initialise S3 bucket as backend
  backend "s3" {
    bucket = "threat-model-app-ecs"
    key    = "terraform.tfstate"
    region = "eu-west-2"

  }
}