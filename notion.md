AI/MLops Infrastucture Systems Project plan 
---

Phase 1: Foundation & Framing [x]
- [ ] Create GitHub repo: `AI-mlops-infra-systems`
- [x] Add folder structure:
- [x] Add README.md with:
  - [ ] Problem → Solution → Business Impact
  - [ ] Quickstart placeholder
  - [ ] Architecture diagram placeholder
  - [ ] Screencast placeholder
- [ ] Create `docs/architecture.png` (initial sketch)
- [ ] Create `docs/screencast.md` with demo note

Phase 2: Infrastructure Bootstrapping task-list []
- [x] Scaffold Terraform modules (local cluster first)
  - [x] Create `infra/terraform/main.tf` for AWS
  - [x] Define provider, cluster resources, and storage backend (EKS + S3 for DVC)
  - [x] Add outputs for kubeconfig and endpoint

- [x] Add Kubernetes manifests 
  - [x] MLflow tracking server
    - [x] `infra/k8s/mlflow-deployment.yaml`
    - [x] `infra/k8s/mlflow-service.yaml`
    - [x] Backend store (PostgreSQL or SQLite) - backend store-SQLite (PostgreSQL for production)
  - [x] DVC-compatible storage (MinIO or S3)
    - [x] `infra/k8s/minio-deployment.yaml`
    - [x] `infra/k8s/minio-service.yaml`
    - [x] Bucket config for DVC remote - See Readme-k8s.md

- [x] Set up GitHub Actions for CI/CD
  - [x] Create `.github/workflows/deploy.yml`
  - [x] Define jobs for Terraform apply + kubectl apply
  - [x] Add secrets for cloud provider and kubeconfig

- [x] Add CI/CD badge to README
  - [x] Status badge for `deploy.yml`
  - [x] Link to Actions dashboard

Phase 3: ML Pipeline Core 
- [ ] Configure MLflow:
  - [ ] Tracking server
  - [ ] Sample experiment + metrics
- [ ] Configure DVC:
  - [ ] Sample dataset
  - [ ] Pipeline stages
- [ ] Build Kubeflow or Airflow DAG:
  - [ ] Ingest → Train → Evaluate → Register

Phase 4: Observability & Reliability
- [ ] Deploy Prometheus + Grafana
- [ ] Create dashboards for:
  - [ ] Resource usage
  - [ ] Training metrics
- [ ] Integrate EvidentlyAI for drift detection
- [ ] Add alerting rules for:
  - [ ] Drift
  - [ ] Failed pipeline stages

🎥 Phase 5: Demo 
- [ ] Record screencast demo (2–3 min)
- [ ] Update `docs/screencast.md` with link
- [ ] Finalize architecture diagram
- [ ] Polish README:
  - [ ] Add badges
  - [ ] Add demo link
  - [ ] Refine impact framing



