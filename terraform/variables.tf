# Cloudflare Zone ID
variable "zone_id" {
  type = string
}

# ECR Container Image URI
variable "container_image" {
  description = "URI of the ECR image to deploy"
}

# Domain purchased through cloudflare
variable "domain_name" {
  type = string
}
