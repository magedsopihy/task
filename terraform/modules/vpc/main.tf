
data "aws_availability_zones" "available" {}


module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.2.0"

  name                 = var.VPC_NAME
  cidr                 = var.VPC_CIDR_BLOCK
  azs                  = data.aws_availability_zones.available.names
  private_subnets      = var.PRIVATE_SUBNET_CIDR
  public_subnets       = var.PUBLIC_SUBNET_CIDR
  enable_nat_gateway   = true
  single_nat_gateway   = true
  enable_dns_hostnames = true

  tags = {
    "kubernetes.io/cluster/${var.CLUSTER_NAME}" = "shared"
  }

  public_subnet_tags = {
    "kubernetes.io/cluster/${var.CLUSTER_NAME}" = "shared"
    "kubernetes.io/role/elb"                      = "1"
  }

  private_subnet_tags = {
    "kubernetes.io/cluster/${var.CLUSTER_NAME}" = "shared"
    "kubernetes.io/role/internal-elb"             = "1"
    
  }
}