variable "zone_id" {
  type = string
}

variable "container_image" {
  description = "URI of the ECR image to deploy"
}

variable "domain_name" {
  type = string
}
