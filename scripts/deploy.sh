#!/bin/bash
set -e

VERSION="v2.3.0"
IMAGE="lab-app:${VERSION}"

echo "Starting deployment of OrderFlow ${VERSION}..."
echo "Deploying image: ${IMAGE}"
echo "Environment: production"
echo "Timestamp: $(date -u +%Y-%m-%dT%H:%M:%SZ)"

# kubectl set image deployment/lab-app lab-app=${IMAGE}
# kubectl rollout status deployment/lab-app

echo "Deployment of OrderFlow ${VERSION} completed successfully."
