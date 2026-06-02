module "vpc" {
  source = "./modules/vpc"
}

module "security" {
  source = "./modules/security"
  vpc_id = module.vpc.vpc_id
}

module "ecr" {
  source = "./modules/ecr"
}

module "alb" {
  source            = "./modules/alb"
  vpc_id            = module.vpc.vpc_id
  public_subnet_ids = module.vpc.public_subnet_ids
  alb_sg_id         = module.security.alb_sg_id
  certificate_arn   = module.acm.certificate_arn
}

module "ecs" {
  source             = "./modules/ecs"
  private_subnet_ids = module.vpc.public_subnet_ids
  ecs_sg_id          = module.security.ecs_sg_id
  target_group_arn   = module.alb.target_group_arn
  repository_url     = module.ecr.repository_url
}

data "aws_route53_zone" "main" {

  name = "yusufdevops.online"
}


module "acm" {
  source      = "./modules/acm"
  domain_name = "tm.yusufdevops.online"
  zone_id     = data.aws_route53_zone.main.zone_id
}

module "route53" {
  source       = "./modules/route53"
  zone_id      = data.aws_route53_zone.main.zone_id
  alb_dns_name = module.alb.alb_dns_name
  alb_zone_id  = module.alb.alb_zone_id
}