locals {
  region = "eu-west-1"
  name = "rks-ekscluster"
  vpc_cidr = "10.0.0.0/16"
  azs             = ["eu-west-1a", "eu-west-1b"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24"]
  intra_subnets   = ["10.0.5.0/24", "10.0.5.0/24"]
  env = "dev"

  principal_arn = "arn:aws:iam::529088294745:user/rks007"
}