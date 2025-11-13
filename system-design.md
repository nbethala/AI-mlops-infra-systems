# System Design Fundamentals Applied to this project from pipeline to platform

## Stage 1: Infrastructure as Code (IaC)
Goal: Provision cloud-native resources reproducibly.

### Tools: Terraform to provision - 
- AWS EKS cluster (compute layer)
- S3 bucket (artifact store for DVC)
- Modularized with main.tf, variables.tf, outputs.tf

### System Design Principles
Declarative provisioning: Infra state lives in Git
Modularity: Reusable Terraform modules
Scalability: EKS supports autoscaling ML workloads
Cost-awareness: make quickstop for teardown hygiene

## Stage 2: Kubernetes-Native ML Platform
Goal: Deploy MLflow and MinIO as core services.

### Tools: Create Kubernetes manifests for:
 - mlflow-deployment.yaml + mlflow-service.yaml
 - minio-deployment.yaml + minio-service.yaml
 - Used SQLite for MLflow backend (lean, fast)
 - Routed external access via NGINX Ingress Controller

### System Design Principles
Service abstraction: Pods + Services = clean separation
Scalable routing: Ingress enables multi-service exposure
Cloud-native storage: MinIO/S3 for artifact persistence
Environment isolation: mlops-system namespace

## Stage 3: Data Versioning and Reproducibility
Goal: Track datasets and models across environments.

### Tools: DVC ( data version control)
- Configured remote pointing to S3
- Automated with make dvc-remote-init
- make dvc-push

### System Design Principles
Immutable data lineage: DVC tracks every dataset version
Cloud-native integration: S3 remote via Terraform
Automation: Makefile targets ensure reproducibility

## Stage 4: CI/CD and Lifecycle Automation
Goal: Automate infra + app deployment from Git.

### Tools: Linux Make utility for automation 
Scaffold Makefile with:
- infra, deploy-mlflow, ingress-controller, quickstart, quickstop
- Planned .github/workflows/deploy.yml for GitHub Actions

### System Design Principles
GitOps readiness: Git is the source of truth
Lifecycle control: quickstart and quickstop mirror real platform automation for quick build and tear down.
Pipeline modularity: Each target is reusable and testable

## Stage 5: Platform Maturity Optional
Goal: Demonstrate production-readiness and architectural clarity.

### Tools: 
 - TLS via cert-manager
 - PostgreSQL backend for MLflow
 - TorchServe or model deployment
 - Observability stack (Prometheus, Grafana)
 - LLM integration and vector DBs

### System Design Principles
Security: TLS, secrets, RBAC
Observability: Metrics, logs, traces
Extensibility: Modular services (MLflow, MinIO, TorchServe)
Resilience: Stateless services + cloud storage

### Repository Structure
```
AI-mlops-infra-systems/
├── infra/
│   ├── terraform/         # IaC for EKS + S3
│   └── k8s/               # MLflow, MinIO, Ingress manifests
├── ml-pipeline/           # DVC-tracked data
├── Makefile               # Lifecycle automation
├── README.md              # For architecture
```