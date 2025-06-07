# Cloudflare zone ID
variable "zone_id" {
  type = string
}

# Domain purchased from cloudflare
variable "domain_name" {
  type = string
}

# TTL
variable "time_to_live" {
  type = number
  description = "Time to Live"
}

# Subdomain
variable "subdomain" {
  type = string
  description = "subdomain of your domain"
}