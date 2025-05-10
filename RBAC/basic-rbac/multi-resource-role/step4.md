# Testing the Multiple Resource Permissions

Now let's test the permissions we've granted to see how they work across different resources.

## Testing Pod Permissions

```bash
# Check if resource-user can list pods
kubectl auth can-i list pods --namespace multi-resource --as resource-user

# Check if resource-user can get pod details
kubectl auth can-i get pods --namespace multi-resource --as resource-user

# Check if resource-user can create pods
kubectl auth can-i create pods --namespace multi-resource --as resource-user

# Check if resource-user can delete pods
kubectl auth can-i delete pods --namespace multi-resource --as resource-user
```

The first two commands should return `yes`, while the last two should return `no`.

## Testing Service Permissions

```bash
# Check if resource-user can list services
kubectl auth can-i list services --namespace multi-resource --as resource-user

# Check if resource-user can update services
kubectl auth can-i update services --namespace multi-resource --as resource-user

# Check if resource-user can create services
kubectl auth can-i create services --namespace multi-resource --as resource-user

# Check if resource-user can delete services
kubectl auth can-i delete services --namespace multi-resource --as resource-user
```

The first two commands should return `yes`, while the last two should return `no`.

## Testing ConfigMap Permissions

```bash
# Check if resource-user can list configmaps
kubectl auth can-i list configmaps --namespace multi-resource --as resource-user

# Check if resource-user can create configmaps
kubectl auth can-i create configmaps --namespace multi-resource --as resource-user

# Check if resource-user can update configmaps
kubectl auth can-i update configmaps --namespace multi-resource --as resource-user

# Check if resource-user can delete configmaps
kubectl auth can-i delete configmaps --namespace multi-resource --as resource-user
```

All of these commands should return `yes` since we granted all verbs for ConfigMaps.

## Testing Secret Permissions

```bash
# Check if resource-user can list secrets
kubectl auth can-i list secrets --namespace multi-resource --as resource-user
```

This should return `no` because we didn't grant any permissions for Secrets.
