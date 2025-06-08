terraform {
  required_version = "1.9.8"
  required_providers {
    # Initialising AWS as a provider
    aws = {
      source  = "hashicorp/aws"
      version = "6.0.0-beta2"
    }
  }
}