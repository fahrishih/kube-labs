# Step 2: Apply Role, RoleBinding and Test Access

Apply the Role that allows read-only access to Pods:

```bash
kubectl apply -f /opt/assets/role.yaml
```

Apply the RoleBinding:

```bash
kubectl apply -f /opt/assets/rolebinding.yaml
```

Create a Pod using the `dev-reader` service account:

```bash
kubectl apply -f /opt/assets/test-pod.yaml
```

Now verify the access:

✅ Can list pods (should return `yes`):

```bash
kubectl auth can-i list pods --as=system:serviceaccount:dev-team:dev-reader -n dev-team
```

❌ Cannot list deployments:

```bash
kubectl auth can-i list deployments --as=system:serviceaccount:dev-team:dev-reader -n dev-team
```

❌ Cannot list secrets:

```bash
kubectl auth can-i list secrets --as=system:serviceaccount:dev-team:dev-reader -n dev-team
```
