# Setting Up the Environment

Let's start by creating a dedicated namespace for our RBAC testing:

```bash
kubectl create namespace rbac-test
```

Now let's create a simple deployment to have some pods to work with:

```bash
kubectl create deployment nginx --image=nginx -n rbac-test
kubectl scale deployment nginx --replicas=3 -n rbac-test
```

Verify that the pods are running:

```bash
kubectl get pods -n rbac-test
```

You should see three nginx pods running in the namespace.

Let's also create a test user certificate for this exercise. In a real cluster, you would use a proper authentication method, but for our scenario, we'll simulate a user:

```bash
# Create a private key for the user
openssl genrsa -out pod-reader.key 2048

# Create a certificate signing request
openssl req -new -key pod-reader.key -out pod-reader.csr -subj "/CN=pod-reader/O=rbac-test"

# Sign the CSR with the Kubernetes CA (in a real setup, this would be done by the cluster admin)
# For this lab environment, we'll simulate this step
echo "User pod-reader created (simulated for lab purposes)"
```

Now we're ready to set up RBAC for this user.
