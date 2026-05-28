output "vpc_id" {
  value = aws_vpc.main.id
}

output "certificate_arn" {
  value = module.acm.certificate_arn
}