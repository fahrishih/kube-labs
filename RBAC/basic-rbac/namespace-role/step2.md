# Creating a Namespace-Scoped Role

A Role contains rules that represent a set of permissions. Permissions are purely additive (there are no "deny" rules).

Let's create a Role that allows read-only access to pods in our namespace:

```bash
cat <<EOF > pod-reader-role.yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  namespace: rbac-test
  name: pod-reader
rules:
- apiGroups: [""] # "" indicates the core API group
  resources: ["pods"]
  verbs: ["get", "watch", "list"]
EOF

kubectl apply -f pod-reader-role.yaml
```

Let's understand the components of this Role:
- `apiGroups`: Specifies which API groups the permissions apply to. The core API group (containing pods, services, etc.) is represented by an empty string.
- `resources`: Defines which resource types this role applies to, in this case, pods.
- `verbs`: Lists the operations that can be performed, here we're allowing read-only operations.

View the created Role:

```bash
kubectl get role pod-reader -n rbac-test -o yaml
```

This Role only grants permissions within the `rbac-test` namespace, as it's namespace-scoped.
