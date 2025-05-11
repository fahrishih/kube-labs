#!/bin/bash
set -ex

# Create namespace rbac-test
echo "Creating namespace rbac-test..."
kubectl create namespace rbac-test

# Create a service account named pod-reader
echo "Creating service account pod-reader..."
kubectl create serviceaccount pod-reader -n rbac-test

echo "Setup complete!"
echo "Namespace 'rbac-test' created"
echo "User 'pod-reader' created with no permissions on the namespace"