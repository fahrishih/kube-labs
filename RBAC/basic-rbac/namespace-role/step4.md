# Testing the RBAC Configuration

Let's test our RBAC setup to verify that the permissions work as expected.

For the sake of this exercise, we'll use the `kubectl auth can-i` command to check permissions for our user:

```bash
# Check if the pod-reader user can list pods in the rbac-test namespace
kubectl auth can-i list pods --namespace rbac-test --as pod-reader
```

You should see `yes`, indicating that the user has this permission.

Let's check if the user can read other resources or perform other actions:

```bash
# Check if pod-reader can create pods
kubectl auth can-i create pods --namespace rbac-test --as pod-reader

# Check if pod-reader can delete pods
kubectl auth can-i delete pods --namespace rbac-test --as pod-reader

# Check if pod-reader can list services
kubectl auth can-i list services --namespace rbac-test --as pod-reader

# Check if pod-reader can list pods in another namespace
kubectl auth can-i list pods --namespace default --as pod-reader
```

All of these should return `no` because our Role only allows reading pods in the rbac-test namespace.

Let's verify we can actually view pod details:

```bash
# Get a pod name
POD_NAME=$(kubectl get pods -n rbac-test -o jsonpath='{.items[0].metadata.name}')

# Try to get pod details as the pod-reader user
kubectl get pod $POD_NAME -n rbac-test --as pod-reader
```

This should succeed and show you the details of the pod.
