# Setting Up the Environment

Let's start by creating a namespace for our multi-resource RBAC testing:

```bash
kubectl create namespace multi-resource
```

Now, let's create several resources in this namespace to work with:

1. Create a deployment with pods:

```bash
kubectl create deployment nginx --image=nginx -n multi-resource
```

2. Create a service:

```bash
kubectl expose deployment nginx --port=80 --name=nginx-service -n multi-resource
```

3. Create a ConfigMap:

```bash
kubectl create configmap app-config --from-literal=key1=value1 --from-literal=key2=value2 -n multi-resource
```

4. Create a Secret:

```bash
kubectl create secret generic app-secret --from-literal=password=supersecret -n multi-resource
```

Verify all resources were created:

```bash
kubectl get pods,services,configmaps,secrets -n multi-resource
```

Let's also create a test user for this scenario:

```bash
# Create a private key for the user
openssl genrsa -out resource-user.key 2048

# Create a certificate signing request
openssl req -new -key resource-user.key -out resource-user.csr -subj "/CN=resource-user/O=multi-resource"

# Sign the CSR with the Kubernetes CA (in a real setup, this would be done by the cluster admin)
# For this lab environment, we'll simulate this step
echo "User resource-user created (simulated for lab purposes)"
```

Now we're ready to set up the multi-resource RBAC permissions.
