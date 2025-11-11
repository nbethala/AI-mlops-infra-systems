# DVC Remote Setup 
# Set your bucket name and region
BUCKET_NAME=ai-mlops-cluster-dvc
REGION=us-east-1
REMOTE_NAME=storage

# DVC remote setup using AWS S3
dvc-remote-init:
    dvc remote add -d $(REMOTE_NAME) s3://$(BUCKET_NAME)/dvc-store
    dvc remote modify $(REMOTE_NAME) endpoint-url https://s3.amazonaws.com
    dvc remote modify $(REMOTE_NAME) region $(REGION)
    dvc remote modify $(REMOTE_NAME) access_key_id $${AWS_ACCESS_KEY_ID}
    dvc remote modify $(REMOTE_NAME) secret_access_key $${AWS_SECRET_ACCESS_KEY}
    @echo "✅ DVC remote '$(REMOTE_NAME)' configured for bucket '$(BUCKET_NAME)'"

# Track and push a sample dataset
dvc-push:
    dvc add ml-pipeline/data/train.csv
    git add ml-pipeline/data/train.csv.dvc .gitignore
    git commit -m "Track training data with DVC"
    dvc push
    @echo "✅ Data pushed to remote '$(REMOTE_NAME)'"

.PHONY: dvc-remote-init dvc-push
