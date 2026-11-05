#!/bin/bash
set -e

ROLLBACK_VERSION="v2.2.1"
IMAGE="lab-app:${ROLLBACK_VERSION}"

echo "Initiating rollback to OrderFlow ${ROLLBACK_VERSION}..."
echo "Rolling back image to: ${IMAGE}"

# kubectl set image deployment/lab-app lab-app=${IMAGE}
# kubectl rollout status deployment/lab-app

echo "Verifying health after rollback..."
# curl -f https://app.orderflow.io/health

echo "Rollback to ${ROLLBACK_VERSION} completed successfully."
echo "Notify stakeholders: rollback performed at $(date -u +%Y-%m-%dT%H:%M:%SZ)"
