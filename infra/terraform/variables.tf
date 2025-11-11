variable "aws_region" {
  default     = "us-east-1"
  description = "AWS region for deployment"
}

variable "cluster_name" {
  type        = string
  default     = "ai-mlops-cluster"
  description = "Name of the EKS cluster and S3 bucket prefix"
}

variable "vpc_id" {
  type        = string
  description = "VPC ID for EKS"
}

variable "subnet_ids" {
  type        = list(string)
  description = "List of subnet IDs for EKS"
}


