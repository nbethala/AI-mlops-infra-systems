# CI/CD Pipeline Overview

The CI/CD pipeline automates the provisioning and deployment of a cloud-native ML Ops platform using:

 - Terraform for AWS infrastructure (EKS + S3)
 - Kubernetes for service orchestration (MLflow, MinIO, Ingress)
 - GitHub Actions for lifecycle automation

### Pipeline Structure
Workflow File
```
.github/workflows/deploy.yml
```

### Trigger 
Every push to main triggers a full infra + app deployment.

### Jobs breakdown 
- Checkout --> Clones the repo
- Terraform Setup --> Installs Terraform CLI
- AWS Credentials	--> Injects secrets for cloud access
- Terraform Apply	--> Provisions EKS + S3
- Kubeconfig Update --> Connects kubectl to EKS
- K8s Deployment --> Applies MLflow, MinIO, and Ingress manifests
- Validation --> Prints cluster state for debugging

### Required GitHub Secrets
- Add below secrets to Github Actions 
AWS_ACCESS_KEY_ID --> 	Auth for Terraform + AWS CLI
AWS_SECRET_ACCESS_KEY -->	Auth for Terraform + AWS CLI

### Verify Cluster Health
```
kubectl get nodes
kubectl get pods -A
kubectl get svc -A
kubectl get ingress -A
```