# Pull AWS region & cluster name from Terraform
export AWS_REGION=$(terraform output -raw region)
export CLUSTER_NAME=$(terraform output -raw cluster_name)

# 1. Merge in kubeconfig under a friendly alias
aws eks update-kubeconfig \
  --region "${AWS_REGION}" \
  --name "${CLUSTER_NAME}" \
  --alias "${CLUSTER_NAME}"

# 2. Switch to the new, aliased context
kubectl config use-context "${CLUSTER_NAME}"

# 3. Set its default namespace to “cockroach”
kubectl config set-context "${CLUSTER_NAME}" --namespace=cockroach

# Verify
kubectl config view --minify

