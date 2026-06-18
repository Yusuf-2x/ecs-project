output "vpc_id" {
  value = module.vpc.vpc_id
}

output "certificate_arn" {
  value = module.acm.certificate_arn
}