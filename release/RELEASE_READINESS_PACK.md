# OrderFlow v2.3.0 — Release Readiness Pack

## Release Information

| Field              | Value                          |
|--------------------|--------------------------------|
| **Product**        | OrderFlow                      |
| **Version**        | v2.3.0                         |
| **Release Date**   | 2026-11-05                     |
| **Environment**    | Production                     |
| **Image Tag**      | `lab-app:v2.3.0`               |
| **Release Manager**| DevOps Lead                    |
| **Approved By**    | Engineering Manager            |
| **Pipeline**       | GitHub Actions — Release Pipeline |

---

## Deployment Instructions

### Prerequisites
- GitHub repository secrets configured: `API_KEY`, `DATABASE_PASSWORD`, `TOKEN`, `AWS_SECRET`
- Kubernetes cluster accessible with `kubectl`
- Terraform state backend configured

### Steps

1. **Merge to `main`** — triggers GitHub Actions Release Pipeline automatically
2. **Validate stage runs first** — tests must pass before production deploys
3. **Production deploy requires manual approval** in GitHub Environments
4. **Verify deployment**:
   ```bash
   kubectl rollout status deployment/lab-app
   curl -f https://app.orderflow.io/health
   ```
5. **Confirm in release summary** that `status: approved` and `version: v2.3.0`

---

## Rollback Strategy

| Field                    | Value                       |
|--------------------------|-----------------------------|
| **Rollback Target**      | v2.2.1                      |
| **Strategy**             | Immediate image revert      |
| **Max Rollback Time**    | 15 minutes                  |
| **Owner**                | DevOps Lead                 |

### Rollback Steps
```bash
# 1. Re-deploy previous stable image
kubectl set image deployment/lab-app lab-app=lab-app:v2.2.1

# 2. Watch rollout
kubectl rollout status deployment/lab-app

# 3. Confirm health
curl -f https://app.orderflow.io/health

# 4. Notify stakeholders
```

Or run the rollback script directly:
```bash
chmod +x scripts/rollback.sh
./scripts/rollback.sh
```

---

## Deployment Infrastructure

| Decision               | Selection       | Reason                                           |
|------------------------|-----------------|--------------------------------------------------|
| **Cloud Provider**     | AWS             | Primary production cloud                        |
| **Instance Type**      | `t3.medium`     | Production-appropriate (upgraded from `t2.micro`)|
| **Orchestration**      | Kubernetes      | Replicas=3, zero-downtime rolling updates        |
| **IaC**               | Terraform       | Reproducible, version-controlled infrastructure  |
| **Image Registry**     | Internal        | Tagged `lab-app:v2.3.0`                          |

> **Note:** `t2.micro` was rejected — it is a development-tier instance type, not suitable for production workloads.

---

## Production Approval Checklist

- [x] Release version confirmed: `v2.3.0`
- [x] All validation tests passed in CI
- [x] No hardcoded secrets in codebase
- [x] Secrets managed via GitHub Actions Secrets and Kubernetes Secrets
- [x] Deployment pipeline stages in correct order (validate → deploy)
- [x] Production environment protection enabled in GitHub
- [x] Rollback plan documented and rollback script tested
- [x] Infrastructure instance type appropriate for production (`t3.medium`)
- [x] Container image version-tagged (`v2.3.0`), not `latest`
- [x] Release documented and approved by Engineering Manager

---

## Deployment Validation Summary

| Check                            | Status  |
|----------------------------------|---------|
| CI validation stage              | ✅ Pass |
| Secret management                | ✅ Pass |
| Version tagging                  | ✅ Pass |
| Pipeline stage order             | ✅ Pass |
| Production approval gate         | ✅ Pass |
| Infrastructure selection         | ✅ Pass |
| Rollback strategy                | ✅ Pass |
| Release documentation complete   | ✅ Pass |

**Release Status: ✅ APPROVED FOR PRODUCTION**
