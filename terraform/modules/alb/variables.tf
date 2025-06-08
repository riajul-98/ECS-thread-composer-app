variable "pub_subnet_id" {
  type = list(string)
}

variable "certificate_arn" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "ecs_port" {
  description = "Port where ECS tasks are listening"
  type        = number
}

variable "listener_http_port" {
  type    = number
  default = 80
}

variable "listener_https_port" {
  type    = number
  default = 443
}

variable "SG_outgoing" {
  type        = list(string)
  description = "Allow outgoing traffic from the specified CIDR"
  default     = ["0.0.0.0/0"]
}

variable "http_ingress_ports" {
  description = "Security group incoming http port"
  type        = number
  default     = 80
}

variable "https_ingress_ports" {
  description = "Security group incoming https port"
  type        = number
  default     = 443
}