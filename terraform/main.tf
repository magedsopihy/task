module "vpc" {
  source              = "./modules/vpc"
  VPC_NAME            = var.VPC_NAME
  VPC_CIDR_BLOCK      = var.VPC_CIDR_BLOCK
  PRIVATE_SUBNET_CIDR = var.PRIVATE_SUBNET_CIDR
  PUBLIC_SUBNET_CIDR  = var.PUBLIC_SUBNET_CIDR
  CLUSTER_NAME        = var.CLUSTER_NAME
}

module "eks" {
  source           = "./modules/eks"
  CLUSTER_NAME     = var.CLUSTER_NAME
  VPC_ID           = module.vpc.vpc_id
  PRIVATE_SUBNETS  = module.vpc.private_subnets
  INSTANCE_TYPE    = var.INSTANCE_TYPE
  DESIRED_CAPACITY = var.DESIRED_CAPACITY
  MAX_CAPACITY     = var.MAX_CAPACITY
  MIN_CAPACITY     = var.MIN_CAPACITY
  VOLUME_TYPE      = var.VOLUME_TYPE
  VOLUME_SIZE      = var.VOLUME_SIZE

}

resource "null_resource" "kubectl" {
  depends_on = [module.eks]
  provisioner "local-exec" {
    command = "aws eks --region ${var.REGION} update-kubeconfig --name ${var.CLUSTER_NAME}"
  }
}

resource "null_resource" "ansible" {
  depends_on = [null_resource.kubectl]
  provisioner "local-exec" {
    command = "ansible-playbook playbook.yaml"
    working_dir = "../ansible"
  }
}

