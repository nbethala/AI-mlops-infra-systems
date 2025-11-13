# K8s Manifest Files : Deploy MLflow + MinIO on Kubernetes (EKS)

### setup
 - MLflow tracking server for experiment reproducibility
 - MinIO as an S3-compatible backend for DVC and MLflow artifacts

### Why use MinIO when we have an AWS S3 storage bucket ?
MinIO works just like AWS S3, but it’s cloud-agnostic — which is exactly why I’m using it. By storing model artifacts in MinIO instead of tying them to a specific cloud provider, I can keep the ML pipelines reproducible and portable. It also makes it easy to plug into CI/CD workflows and deploy across hybrid or cloud-native environments.

```
infra/k8s/
├── mlflow-deployment.yaml
├── mlflow-service.yaml
├── minio-deployment.yaml
├── minio-service.yaml
└── namespace.yaml
```

- namespace.yaml - Lets use a dedicated namespace to Isolates MLflow and MinIO from other workloads.

### Manifest - Works on EKS, AKS, GKE, or K3s
Can be deployed via 
```
kubectl apply -f infra/k8s/
```

### DVC Remote Configuration 
This project uses [DVC](https://dvc.org/) to version datasets and models, with remote storage backed by either AWS S3 or in-cluster MinIO.

### Option 1 : AWS S3 (Provisioned via Terraform) 
```
#Initialized DVC repo (reates .dvc/ and .dvc/config)
dvc init

#Provisioned an S3 bucket via Terraform
add to main.tf 

#Configured DVC to use that bucket
#This step connects your local repo to the remote bucket, enabling push/pull of versioned data.
dvc remote add -d storage s3://ai-mlops-cluster-dvc/dvc-store
dvc remote modify storage endpoint-url https://s3.amazonaws.com
dvc remote modify storage region us-east-1
dvc remote modify storage access_key_id <your-access-key>
dvc remote modify storage secret_access_key <your-secret-key>
```

### Track a dataset 
```
dvc add data/raw/train.csv
git add data/raw/train.csv.dvc .gitignore
git commit -m "Track training data with DVC"
```

### Pushed to remote
```
dvc push
```

### Option 2 : DVC remote setup 
Execute the Makefile with the DVC remote setup
```
export AWS_ACCESS_KEY_ID=your-key
export AWS_SECRET_ACCESS_KEY=your-secret

make dvc-remote-init   # Sets up the remote
make dvc-push          # Tracks and pushes data
```
### setup SQLite for MLflow backend store
 - Storage Strategy :
     - SQLite .db file lives inside the MLflow pod
     - Artifact metadata stored in .db
     - Actual artifacts stored in S3 (provisioned via Terraform)
     - Future enhancements - Add a PersistentVolumeClaim if you want to persist the .db across pod    restarts . Switch to PostgreSQL via Helm when scaling to multi-user or CI/CD pipelines