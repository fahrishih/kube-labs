# Hints for Creating the RoleBinding

If you've successfully created your Role but are stuck on the RoleBinding, here are some helpful hints.

<details>
<summary>RoleBinding Structure Hint</summary>

A RoleBinding needs these key components:
- apiVersion: rbac.authorization.k8s.io/v1
- kind: RoleBinding
- metadata: with name and namespace
- subjects: who gets the permissions (users, groups, or service accounts)
- roleRef: which Role to bind to the subjects

</details>

<details>
<summary>Complete RoleBinding Example</summary>

```yaml
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
```

You can create this RoleBinding with:
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

</details>

Remember that:
- The `subjects` section specifies who gets the permissions
- The `roleRef` section must reference the Role you created earlier
- The `roleRef` is immutable after creation - if you make a mistake, you'll need to delete and recreate the RoleBinding
- RoleBindings are namespace-specific, like Roles

Once you've created your RoleBinding, proceed to testing your configuration!
