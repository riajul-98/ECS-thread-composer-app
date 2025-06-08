variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "subnet_CIDRs" {
  type        = list(string)
  description = "Subnet CIDR blocks"
  default     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24", "10.0.4.0/24"]
}

variable "availability_zones" {
  type    = list(string)
  default = ["eu-west-2a", "eu-west-2b"]
}