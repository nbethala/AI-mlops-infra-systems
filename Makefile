# automation - setup infra

# === Variables ===
CLUSTER_NAME=ai-mlops-cluster
REGION=us-east-1
DVC_REMOTE=storage
BUCKET_NAME=$(CLUSTER_NAME)-dvc

# === Terraform Infrastructure ===
infra:
    @echo "Provisioning EKS and S3 via Terraform..."
    terraform -chdir=infra/terraform init
    terraform -chdir=infra/terraform apply -auto-approve
    @echo " Terraform Infrastructure provisioned"

# === Kubernetes Deployment ===
deploy-mlflow:
    @echo "Deploying MLflow tracking server..."
    kubectl apply -f infra/k8s/mlflow/mlflow-deployment.yaml
    kubectl apply -f infra/k8s/mlflow/mlflow-service.yaml
    @echo "MLflow deployed"

deploy-minio:
    @echo "Deploying MinIO object store..."
    kubectl apply -f infra/k8s/minio/minio-deployment.yaml
    kubectl apply -f infra/k8s/minio/minio-service.yaml
    @echo "MinIO deployed"

# === Ingress Controller and Routing ===
ingress-controller:
    @echo "Installing NGINX Ingress Controller..."
    helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
    helm repo update
    helm install ingress-nginx ingress-nginx/ingress-nginx \
        --namespace ingress-nginx --create-namespace \
        --set controller.publishService.enabled=true
    @echo "Ingress Controller installed"

ingress-routes:
    @echo "Applying Ingress routes..."
    kubectl apply -f infra/k8s/ingress/ingress-routes.yaml
    @echo "Ingress routing configured"

# === DVC Remote Setup ===
dvc-remote-init:
    @echo "🔧 Configuring DVC remote..."
    dvc remote add -d $(DVC_REMOTE) s3://$(BUCKET_NAME)/dvc-store
    dvc remote modify $(DVC_REMOTE) endpoint-url https://s3.amazonaws.com
    dvc remote modify $(DVC_REMOTE) region $(REGION)
    dvc remote modify $(DVC_REMOTE) access_key_id $${AWS_ACCESS_KEY_ID}
    dvc remote modify $(DVC_REMOTE) secret_access_key $${AWS_SECRET_ACCESS_KEY}
    @echo "DVC remote configured"

dvc-push:
    @echo "Tracking and pushing data to DVC remote..."
    dvc add ml-pipeline/data/train.csv
    git add ml-pipeline/data/train.csv.dvc .gitignore
    git commit -m "Track training data with DVC"
    dvc push
    @echo "Data pushed to remote"

# === Phony Targets ===
.PHONY: infra deploy-mlflow deploy-minio ingress-controller ingress-routes dvc-remote-init dvc-push

# === One-Command Bootstrap using quickstart ===
quickstart: infra deploy-mlflow deploy-minio ingress-controller ingress-routes dvc-remote-init
    @echo "Quickstart complete: EKS, MLflow, MinIO, Ingress, and DVC remote are live!"


# === One-Command Teardown using quickstop ===
quickstop:
    @echo "⚠️ Destroying cloud infrastructure (EKS + S3)..."
    terraform -chdir=infra/terraform destroy -auto-approve
    @echo "🧹 Cleanup complete: Cloud resources deprovisioned"
