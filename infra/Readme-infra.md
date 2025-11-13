The infrastructure setup provisions:

 - An EKS cluster for MLflow, DVC, TorchServe
 - An S3 bucket for DVC remote storage
 - Outputs for kubeconfig and cluster name

 Terraform Infra Setup for EKS + S3

 infra/terraform/
├── main.tf          # Core resources (EKS, S3)
├── variables.tf     # Input variables
├── outputs.tf       # Useful outputs (cluster name, bucket)
├── provider.tf      # AWS provider config
└── backend.tf       # (Optional) remote state config

### What have been achieved ?
- EKS cluster 
- S3 bucket for DVC

### Optional Services for Production 
-  Remote State Storage in S3 buckets
-  DynamoDB for state locking 
-  IAM Roles for EKS Access
-  Security Groups & Networking if not using VPC 
- IRSA (IAM Roles for Service Accounts) to allow Kubernetes pods to access AWS resources securely
- Terraform Workspace - setup dev and production separately 

### quickstart & quickstop :
# === One-Command startdown ===
```
export AWS_ACCESS_KEY_ID=your-key
export AWS_SECRET_ACCESS_KEY=your-secret

make quickstart
```

# === One-Command Teardown ===
 ```
     make quickstop
```

