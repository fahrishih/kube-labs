# Challenge Setup: RBAC for Pod Reading

We've already prepared an environment for you. Run these commands to check what's available:

```bash
# Check the rbac-test namespace that has been created for you
kubectl get namespace rbac-test

# Check the deployment and pods running in this namespace
kubectl get pods -n rbac-test
```

## Your Challenge

A user named `pod-reader` needs to be given permission to:
1. Read (get, list, watch) pods in the `rbac-test` namespace
2. No permission to modify pods or access other resources 
3. No permission to access resources in other namespaces

### Tasks:
1. Create a Role that provides read-only access to pods in the rbac-test namespace
2. Create a RoleBinding that associates this Role with the user "pod-reader"
3. Test your configuration to ensure it provides exactly the access needed

### Hint:
<details>
<summary>Hint 1: Role creation</summary>
A Role needs apiGroups, resources, and verbs. For pod reading, you need the core API group (""), the "pods" resource, and verbs like "get", "list", and "watch".
</details>

<details>
<summary>Hint 2: RoleBinding creation</summary>
Your RoleBinding needs a reference to the Role you created and should specify the "pod-reader" user in its subjects section.
</details>

> Note: For this challenge, we've simulated the existence of a user named "pod-reader". In a real cluster, you would need to create certificates and configure authentication properly.

Begin your challenge now!
