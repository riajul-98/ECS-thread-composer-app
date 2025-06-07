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