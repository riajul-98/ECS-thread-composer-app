# Setting up CNAME record
resource "cloudflare_dns_record" "ecs_record" {
  zone_id = var.zone_id
  name    = "tm"
  type    = "CNAME"
  content = var.alb_dns
  ttl     = 3600
}
