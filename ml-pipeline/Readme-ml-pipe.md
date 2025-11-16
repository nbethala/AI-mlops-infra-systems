# ML Lifecycle Workspace
This folder encapsulates the data, code, artifacts, and metrics for the ML pipeline. It’s tracked by DVC and orchestrated via Airflow or Makefile.

### data — Raw and Cleaned Datasets
- housing.csv - Raw dataset (California Housing Prices)
- clean.csv - Cleaned version after ingest stage
- .dvc files - DVC tracking metadata for versioning

### src — Pipeline Scripts
ingest.py - Cleans and prepares raw data
train.py - Trains regression model
evaluate.py	- Computes metrics like RMSE
tune.py (optional)	- Hyperparameter tuning logic
register.py (optional) - Logs model to MLflow or registry

### Model Artifacts - model registry saved, versioned and ready for deployment.
model.pkl- Trained regression model (via joblib)
best_params.json -  (optional)	Tuned hyperparameters
.dvc files - DVC tracking for model reproducibility

### metrics — Evaluation Outputs
metrics.json- RMSE, MAE, R², etc. from evaluation
tuning_metrics.json - (optional)	Metrics from hyperparameter tuning

### dvc.yaml — Pipeline Definition
Pipeline config - Defines stages: ingest → train → evaluate
Dependencies - Tracks inputs and outputs for each stage
Reproducibility - Enables dvc repro to rerun pipeline end-to-end

### dvc.yaml — This Pipeline is your backbone  
Pipeline config- Defines stages: ingest → train → evaluate
Dependencies - Tracks inputs and outputs for each stage
Reproducibility - Enables dvc repro to rerun pipeline end-to-end

### ML Lifecycle Mapping 
data/ --> Ingest + versioning
src/ --> Execution logic
models/	--> Registry + deployment
metrics/ --> Evaluation + observability
dvc.yaml --> Pipeline orchestration

## Setup Instructions 
### Ingest: Load and clean housing.csv → clean.csv

Train: Fit regression model → model.pkl

Evaluate: Assess performance → metrics.json

ML-pipeline : 

Step 1: Download and Save python script ( california housing prices)
Step 2: 
Step 2: Track with DVC
cd ml-pipeline
dvc init
dvc add data/housing.csv
git add data/housing.csv.dvc .gitignore
git commit -m "Track California housing dataset"
dvc push

Step 3: Scaffold Pipeline Scripts
- src/ingest.py
- src/train.py
- src/evaluate.py

Step 4 - src/dvc.yaml 

Step 5: Run and Validate
dvc repro
dvc metrics show

Step 6: Document Each Stage
docs/pipeline.md
Dataset source and schema

Pipeline stages (ingest → train → evaluate)

Sample metrics and model file

Screenshot of MLflow or DVC output