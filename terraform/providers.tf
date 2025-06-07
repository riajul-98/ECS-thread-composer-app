terraform {
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
    bucket = var.backend_bucket
    key    = var.bucket_key
    region = var.region

  }
}