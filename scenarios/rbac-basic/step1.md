# Step 1: Set up Namespace and Service Account

First, create a namespace called `dev-team`:

```bash
kubectl create namespace dev-team
```

Now create a service account named `dev-reader` in the `dev-team` namespace:

```bash
kubectl create serviceaccount dev-reader -n dev-team
```

You can verify:

```bash
kubectl get serviceaccount -n dev-team
```
