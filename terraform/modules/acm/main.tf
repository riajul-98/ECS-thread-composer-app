# Setting up ACM for Load Balancer
resource "cloudflare_dns_record" "acm_cert_validation" {
  zone_id    = var.zone_id
  name       = tolist(aws_acm_certificate.cert.domain_validation_options)[0].resource_record_name
  type       = tolist(aws_acm_certificate.cert.domain_validation_options)[0].resource_record_type
  content    = tolist(aws_acm_certificate.cert.domain_validation_options)[0].resource_record_value
  ttl        = var.time_to_live
  depends_on = [aws_acm_certificate.cert]
}

resource "aws_acm_certificate_validation" "cert_validation" {
  certificate_arn = aws_acm_certificate.cert.arn
  validation_record_fqdns = [
    tolist(aws_acm_certificate.cert.domain_validation_options)[0].resource_record_name
  ]
}

resource "aws_acm_certificate" "cert" {
  domain_name       = "${var.subdomain}.${var.domain_name}"
  validation_method = "DNS"
  lifecycle {
    create_before_destroy = true
  }
}
