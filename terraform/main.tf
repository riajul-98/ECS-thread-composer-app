module "vpc" {
  source = "./modules/vpc"
}

module "acm" {
  source      = "./modules/acm"
  domain_name = var.domain_name
  zone_id     = var.zone_id
}

module "alb" {
  source          = "./modules/alb"
  pub_subnet_id   = module.vpc.pub_subnet_id
  certificate_arn = module.acm.certificate_arn
  vpc_id          = module.vpc.vpc_id
}

module "iam" {
  source = "./modules/iam_role"
}

module "ecs" {
  source           = "./modules/ecs"
  alb_sg_id        = module.alb.alb_sg_id
  target_group_arn = module.alb.target_group_arn
  iam_role_arn     = module.iam.iam_role_arn
  container_image  = var.container_image
  priv_sub_id      = module.vpc.priv_sub_id
  vpc_id = module.vpc.vpc_id
  http_listener_arn = module.alb.http_listener_arn
  https_listener_arn = module.alb.https_listener_arn
}

module "domain" {
  source  = "./modules/domain"
  alb_dns = module.alb.alb_dns
  zone_id = var.zone_id
}
