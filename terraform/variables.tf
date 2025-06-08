# Cloudflare Zone ID
variable "zone_id" {
  description = "Cloudflare domain zoneID"
  type        = string
}

# ECR Container Image URI
variable "container_image" {
  type        = string
  description = "URI of the ECR image to deploy"
}

# Domain purchased through cloudflare
variable "domain_name" {
  type = string
}

variable "ecs_port" {
  description = "Port where ECS tasks are listening"
  type        = number
}

variable "time_to_live" {
  type        = number
  description = "Time to Live"
  default     = 300
}

variable "subdomain" {
  type        = string
  description = "subdomain of your domain"
}

variable "ecs_launch_type" {
  description = "Fargate or EC2"
  type        = string
}

variable "desired_number" {
  description = "Desired number of ECS tasks"
  type        = number
  default     = 2
}

variable "number_of_cpu" {
  description = "Number of ECS CPUs"
  type        = number
}

variable "mem" {
  description = "Memory allocation for ECS"
  type        = number
}