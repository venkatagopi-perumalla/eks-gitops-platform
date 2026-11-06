#!/usr/bin/env bash
# One-time setup: writes your AWS account ID and GitHub repo into the config files.
# Usage: scripts/configure.sh <github-user>/<repo-name>
set -euo pipefail
cd "$(dirname "$0")/.."

REPO="${1:?Usage: scripts/configure.sh <github-user>/<repo-name>}"
ACCOUNT_ID="$(aws sts get-caller-identity --query Account --output text)"

echo "AWS account: $ACCOUNT_ID"
echo "GitHub repo: $REPO"

sed -i.bak "s/ACCOUNT_ID/$ACCOUNT_ID/g" helm/shop/values-eks.yaml
sed -i.bak "s#venkatagopi-perumalla/eks-gitops-platform#$REPO#g" gitops/argocd/shop-app.yaml infra/terraform/envs/dev/terraform.tfvars
sed -i.bak "s/ACCOUNT_ID/$ACCOUNT_ID/g" infra/terraform/envs/dev/backend.tf
find . -name "*.bak" -delete
echo "Done. Review the changes with: git diff"
