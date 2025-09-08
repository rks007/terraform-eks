module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "${local.name}-vpc"
  cidr = local.vpc_cidr

  azs             = local.azs
  private_subnets = local.private_subnets
  public_subnets  = local.public_subnets
#   intra_subnets   = local.intra_subnets # high security practices used in gov, banks so, only private subnets for control plane also, used by 95% of companies

  enable_nat_gateway = true
  enable_vpn_gateway = true

  tags = {
    Terraform = "true"
    Environment = local.env
  }

}