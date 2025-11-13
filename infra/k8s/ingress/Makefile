# Install NGINX Ingress Controller via Helm
ingress-controller:
    @echo "🔧 Installing NGINX Ingress Controller via Helm..."
    helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
    helm repo update
    helm install ingress-nginx ingress-nginx/ingress-nginx \
        --namespace ingress-nginx --create-namespace \
        --set controller.publishService.enabled=true
    @echo "✅ Ingress Controller installed in 'ingress-nginx' namespace"

# Apply Ingress routes for MLflow and MinIO
ingress-routes:
    kubectl apply -f k8s/ingress/ingress-routes.yaml
    @echo "✅ Ingress routes applied for MLflow and MinIO"

.PHONY: ingress-controller ingress-routes
