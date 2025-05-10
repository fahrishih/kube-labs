# Creating a RoleBinding

Now that we have defined the permissions in our Role, we need to bind it to the user. A RoleBinding grants the permissions defined in a role to a user or set of users.

Let's create a RoleBinding that binds our pod-reader Role to the pod-reader user:

```bash
cat <<EOF > pod-reader-rolebinding.yaml
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
EOF

kubectl apply -f pod-reader-rolebinding.yaml
```

Let's understand the components of this RoleBinding:
- `subjects`: Specifies the users, groups, or service accounts that are being granted the role
- `roleRef`: References the role being granted to the subjects (must reference a Role in the same namespace)

View the created RoleBinding:

```bash
kubectl get rolebinding read-pods -n rbac-test -o yaml
```

The RoleBinding is now connecting the pod-reader user to the pod-reader Role in the rbac-test namespace.
