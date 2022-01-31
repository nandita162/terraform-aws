##### root/main.tf ######

module "vpc" {
  source = "./vpc"
  cidr = local.vpc_cidr 
  public_cidrs = ["10.0.1.0/24","10.0.2.0/24","10.0.3.0/24"]
  private_cidrs = ["10.0.4.0/24","10.0.5.0/24","10.0.6.0/24"]
  security_groups = local.security_groups
}