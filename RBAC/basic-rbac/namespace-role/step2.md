# Hints for Creating the Role

If you're stuck on creating the Role, here are some more detailed hints.

<details>
<summary>Role Structure Hint</summary>

A Role needs these key components:
- apiVersion: rbac.authorization.k8s.io/v1
- kind: Role
- metadata: with name and namespace
- rules: defining what resources and actions are permitted

</details>

<details>
<summary>Complete Role Example</summary>

```yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  namespace: rbac-test
  name: pod-reader
rules:
- apiGroups: [""] # "" indicates the core API group
  resources: ["pods"]
  verbs: ["get", "watch", "list"]
```

You can create this Role with:
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

</details>

Remember that:
- The empty string `""` in apiGroups refers to the core API group
- The `verbs` define what actions are permitted on the resources
- This Role is namespace-scoped, so it only applies to the namespace listed in the metadata

Try creating your Role before moving on to the RoleBinding!
