module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  version         = "17.24.0"
  cluster_name    = var.CLUSTER_NAME
  cluster_version = "1.20"
  vpc_id = var.VPC_ID
  subnets = var.PRIVATE_SUBNETS
  

  workers_group_defaults = {
    root_volume_type = "gp2"
  }

  worker_groups = [
    {
      name                          = "worker-group-1"
      instance_type                 =  var.INSTANCE_TYPE
      additional_userdata           = "echo foo bar"
      asg_desired_capacity          = var.DESIRED_CAPACITY
    },
  ]
}


data "aws_eks_cluster" "cluster" {
  name = module.eks.cluster_id
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.eks.cluster_id
}