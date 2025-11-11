terraform {
  backend "s3" {
    bucket = "ai-mlops-terraform-state"
    key    = "eks/terraform.tfstate"
    region = "us-east-1"
  }
}
