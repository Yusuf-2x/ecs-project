terraform {
  backend "s3" {
    bucket       = "yusuf-ecs-terraform-state"
    key          = "ecs-project/terraform.tfstate"
    region       = "eu-west-2"
    use_lockfile = true
  }
}