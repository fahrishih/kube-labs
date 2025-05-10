# Verifying Your RBAC Configuration

Now that you've created your Role and RoleBinding, it's time to verify that they work correctly.

## Challenge Verification

Run the following commands to test if your RBAC configuration is correct:

```bash
# This should return "yes" if your configuration is correct
kubectl auth can-i list pods --namespace rbac-test --as pod-reader

# These should all return "no" if your Role is properly restricted
kubectl auth can-i create pods --namespace rbac-test --as pod-reader
kubectl auth can-i delete pods --namespace rbac-test --as pod-reader
kubectl auth can-i list services --namespace rbac-test --as pod-reader
kubectl auth can-i list pods --namespace default --as pod-reader
```

## Test Accessing Pod Information

Let's test that the `pod-reader` user can actually view pod details:

```bash
# Get a pod name
POD_NAME=$(kubectl get pods -n rbac-test -o jsonpath='{.items[0].metadata.name}')

# Try to get pod details as the pod-reader user
kubectl get pod $POD_NAME -n rbac-test --as pod-reader
```

## Automatic Verification Check

Run this script to automatically verify your solution:

```bash
echo "Verifying RBAC configuration..."

# Check if the Role exists
if ! kubectl get role pod-reader -n rbac-test &> /dev/null; then
  echo "❌ Role 'pod-reader' not found in namespace 'rbac-test'"
  exit 1
fi

# Check if the RoleBinding exists
if ! kubectl get rolebinding read-pods -n rbac-test &> /dev/null; then
  echo "❌ RoleBinding 'read-pods' not found in namespace 'rbac-test'"
  exit 1
fi

# Verify permissions
if [[ $(kubectl auth can-i list pods --namespace rbac-test --as pod-reader) != "yes" ]]; then
  echo "❌ 'pod-reader' cannot list pods in 'rbac-test' namespace"
  exit 1
fi

if [[ $(kubectl auth can-i create pods --namespace rbac-test --as pod-reader) != "no" ]]; then
  echo "❌ 'pod-reader' can create pods in 'rbac-test' namespace - this should be denied"
  exit 1
fi

if [[ $(kubectl auth can-i list pods --namespace default --as pod-reader) != "no" ]]; then
  echo "❌ 'pod-reader' can list pods in 'default' namespace - this should be denied"
  exit 1
fi

echo "✅ Congratulations! Your RBAC configuration passed all checks!"
```

## Complete Challenge Review

<details>
<summary>Complete Solution</summary>

If you had trouble completing the challenge, here's the complete solution:

1. Create the Role:
```yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  namespace: rbac-test
  name: pod-reader
rules:
- apiGroups: [""]
  resources: ["pods"]
  verbs: ["get", "watch", "list"]
```

2. Create the RoleBinding:
```yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  name: read-pods
  namespace: rbac-test
subjects:
- kind: User
  name: pod-reader
  apiGroup: rbac.authorization.k8s.io
roleRef:
  kind: Role
  name: pod-reader
  apiGroup: rbac.authorization.k8s.io
```

</details>

## Key Lessons from this Challenge:
- Roles define permissions (what can be done)
- RoleBindings connect users to Roles (who can do it)
- Namespace-scoped Roles only apply within their namespace
- RBAC permissions are additive - there are no deny rules
