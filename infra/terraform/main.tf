provider "aws" {
  region = var.aws_region
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "19.16.0"  # Pin to a stable version

  cluster_name    = var.cluster_name
  cluster_version = "1.27"
  subnet_ids      = var.subnet_ids
  vpc_id          = var.vpc_id

  enable_irsa = true

  eks_managed_node_groups = {
    default = {
      instance_types = ["t3.medium"]
      min_size       = 1
      max_size       = 3
      desired_size   = 2
    }
  }
}


resource "aws_s3_bucket" "dvc_bucket" {
  bucket        = "${var.cluster_name}-dvc"
  force_destroy = true

  tags = {
    Name        = "DVC Bucket"
    Environment = "mlops"
  }
}
