# Namespace-Scoped Role and RoleBinding for Pod Read Access

In this scenario, you will learn about basic RBAC (Role-Based Access Control) concepts in Kubernetes by creating and using namespace-scoped Roles and RoleBindings.

You will:
- Create a dedicated namespace for testing
- Create a Role that allows read-only access to Pods
- Create a RoleBinding to assign the Role to a user
- Verify the permissions work as expected
- Test the limitations of the Role

RBAC is crucial for securing your Kubernetes cluster by ensuring users and service accounts only have access to the resources they need.
