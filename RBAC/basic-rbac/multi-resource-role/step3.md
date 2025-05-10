# Creating a RoleBinding for Multiple Resources

With our Role defined, we now need to bind it to our user through a RoleBinding:

```bash
cat <<EOF > multi-resource-rolebinding.yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  name: multi-resource-binding
  namespace: multi-resource
subjects:
- kind: User
  name: resource-user
  apiGroup: rbac.authorization.k8s.io
roleRef:
  kind: Role
  name: multi-resource-role
  apiGroup: rbac.authorization.k8s.io
EOF

kubectl apply -f multi-resource-rolebinding.yaml
```

The RoleBinding connects our resource-user to the multi-resource-role in the multi-resource namespace.

Let's verify the RoleBinding:

```bash
kubectl get rolebinding multi-resource-binding -n multi-resource -o yaml
```

A few important things to note about this RoleBinding:

1. It exists in the same namespace as the Role it references
2. The roleRef section is not editable once created - if you need to change the Role, you need to delete and recreate the RoleBinding
3. A RoleBinding can reference any Role in the same namespace
4. You can add multiple subjects (users, groups, or service accounts) to a RoleBinding
