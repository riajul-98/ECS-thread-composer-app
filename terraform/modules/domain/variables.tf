variable "zone_id" {
  type = string
}

variable "alb_dns" {
  type = string
}

variable "record_type" {
  type    = string
  default = "CNAME"
}

variable "time_to_live" {
  type        = number
  description = "Time to Live"
  default     = 300
}

variable "subdomain" {
  type = string
}