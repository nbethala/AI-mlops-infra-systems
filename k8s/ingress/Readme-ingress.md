## Ingress Controller Setup

This project uses NGINX Ingress Controller to expose MLflow and MinIO via path-based routing:

- `/mlflow` → MLflow tracking server
- `/minio` → MinIO object store

### Helm 
Ingress is deployed via Helm command. Why ? - Helm charts dynamically generate the necessary Kubernetes YAML under the hood. So, instead of getting tangled in writing your yaml mess, use the helm chart.

🧠 Why Use an Ingress Controller?
✅ One public IP for all services (MLflow, MinIO, etc.)
✅ Path-based routing (/mlflow, /minio)
✅ TLS termination (easy HTTPS)
✅ Cleaner CI/CD and observability

### Install NGINX Ingress Controller on EKS
📁 Folder: k8s/ingress/
k8s/ingress/
├── ingress-controller.yaml
├── ingress-routes.yaml

### Usage : 
make ingress-controller   # Installs the controller
make ingress-routes       # Applies your routing rules

### What is Achieved 
 - ingress-controller -  installs the NGINX Ingress Controller with a public LoadBalancer IP
 - ingress-routes - applies custom routing rules (e.g., /mlflow, /minio)


