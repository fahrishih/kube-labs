# Creating a Role with Multiple Resource Permissions

Now, let's create a Role that grants access to multiple resource types: Pods, Services, and ConfigMaps.

We'll create a Role that allows:
- Reading pods (get, list, watch)
- Reading and updating services (get, list, watch, update)
- Full control over ConfigMaps (all verbs)

```bash
cat <<EOF > multi-resource-role.yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  namespace: multi-resource
  name: multi-resource-role
rules:
- apiGroups: [""]
  resources: ["pods"]
  verbs: ["get", "list", "watch"]
- apiGroups: [""]
  resources: ["services"]
  verbs: ["get", "list", "watch", "update"]
- apiGroups: [""]
  resources: ["configmaps"]
  verbs: ["*"]
EOF

kubectl apply -f multi-resource-role.yaml
```

Let's examine the key components of this Role:

1. We're defining three separate rule blocks, each for a different resource type
2. Each rule has different permissions:
   - Pods: read-only
   - Services: read and update
   - ConfigMaps: all operations

The `"*"` verb is a wildcard that represents all possible verbs, including:
- get
- list
- watch
- create
- update
- patch
- delete

View the created Role:

```bash
kubectl get role multi-resource-role -n multi-resource -o yaml
```

This Role still respects namespace boundaries - it only grants these permissions within the multi-resource namespace.
