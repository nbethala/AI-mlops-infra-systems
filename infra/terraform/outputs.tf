output "cluster_name" {
  value = module.eks.cluster_name
}

output "kubeconfig" {
  value = module.eks.kubeconfig
}

output "dvc_bucket_name" {
  value = aws_s3_bucket.dvc_bucket.id
}
