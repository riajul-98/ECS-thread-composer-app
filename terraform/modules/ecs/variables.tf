variable "alb_sg_id" {
  type = string
}

variable "target_group_arn" {
  type = string
}

variable "iam_role_arn" {
  type = string
}

variable "container_image" {
  type = string
}

variable "priv_sub_id" {
  type = list(string)
}

variable "vpc_id" {
  type = string
}

variable "http_listener_arn" {
  type = string
}

variable "https_listener_arn" {
  type = string
}

variable "ecs_port" {
  description = "listening port on ECS"
  type        = number
}

variable "ecs_launch_type" {
  description = "Fargate or EC2"
  type        = string
}

variable "desired_number" {
  description = "Desired number of tasks"
  type        = number
}

variable "number_of_cpu" {
  description = "Number of ECS CPUs"
  type        = number
}

variable "mem" {
  description = "Memory allocation for ECS"
  type        = number
}

variable "SG_outgoing" {
  type    = list(string)
  default = ["0.0.0.0/0"]
}

variable "container_name" {
  type = string
  description = "Name which you want to name your container"
  default = "threat-composer"
}