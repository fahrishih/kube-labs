#!/bin/bash
set -e

# Initialize status
PASS=0
TOTAL_CHECKS=0

echo "Verifying RBAC configuration..."

# Check 1: Verify if a Role exists in the rbac-test namespace
((TOTAL_CHECKS++))
if kubectl get role -n rbac-test | grep -q .; then
  echo "✅ Role exists in rbac-test namespace"
  ROLE_NAME=$(kubectl get role -n rbac-test -o jsonpath='{.items[0].metadata.name}')
  ((PASS++))
else
  echo "❌ No Role found in rbac-test namespace"
  exit 1
fi

# Check 2: Verify if the Role has the correct permissions
((TOTAL_CHECKS++))
VERBS=$(kubectl get role $ROLE_NAME -n rbac-test -o jsonpath='{.rules[0].verbs}')
RESOURCES=$(kubectl get role $ROLE_NAME -n rbac-test -o jsonpath='{.rules[0].resources}')

if [[ $VERBS == *"get"* && $VERBS == *"list"* && $VERBS == *"watch"* && $RESOURCES == *"pods"* ]]; then
  echo "✅ Role has correct permissions for reading pods"
  ((PASS++))
else
  echo "❌ Role doesn't have the correct permissions. It should allow get, list, and watch on pods."
  exit 1
fi

# Check 3: Verify if a RoleBinding exists
((TOTAL_CHECKS++))
if kubectl get rolebinding -n rbac-test | grep -q .; then
  echo "✅ RoleBinding exists in rbac-test namespace"
  ROLEBINDING_NAME=$(kubectl get rolebinding -n rbac-test -o jsonpath='{.items[0].metadata.name}')
  ((PASS++))
else
  echo "❌ No RoleBinding found in rbac-test namespace"
  exit 1
fi

# Check 4: Verify if the RoleBinding connects the Role with pod-reader
((TOTAL_CHECKS++))
SUBJECT_KIND=$(kubectl get rolebinding $ROLEBINDING_NAME -n rbac-test -o jsonpath='{.subjects[0].kind}')
SUBJECT_NAME=$(kubectl get rolebinding $ROLEBINDING_NAME -n rbac-test -o jsonpath='{.subjects[0].name}')
ROLE_REF=$(kubectl get rolebinding $ROLEBINDING_NAME -n rbac-test -o jsonpath='{.roleRef.name}')

if [[ "$SUBJECT_KIND" == "ServiceAccount" && "$SUBJECT_NAME" == "pod-reader" && "$ROLE_REF" == "$ROLE_NAME" ]]; then
  echo "✅ RoleBinding correctly links pod-reader to the Role"
  ((PASS++))
else
  echo "❌ RoleBinding doesn't correctly link pod-reader to the Role"
  exit 1
fi

# Check 5: Verify permissions practically - can pod-reader read pods
((TOTAL_CHECKS++))
# Create a test pod if none exists
if ! kubectl get pods -n rbac-test | grep -q .; then
  kubectl run test-pod --image=nginx -n rbac-test
  sleep 5 # Give time for the pod to start
fi

if kubectl auth can-i get pods -n rbac-test --as=system:serviceaccount:rbac-test:pod-reader; then
  echo "✅ pod-reader can read pods in rbac-test namespace"
  ((PASS++))
else
  echo "❌ pod-reader cannot read pods in rbac-test namespace"
  exit 1
fi

# Check 6: Verify pod-reader cannot modify pods
((TOTAL_CHECKS++))
if ! kubectl auth can-i delete pods -n rbac-test --as=system:serviceaccount:rbac-test:pod-reader; then
  echo "✅ pod-reader cannot delete pods in rbac-test namespace"
  ((PASS++))
else
  echo "❌ pod-reader can delete pods in rbac-test namespace - permissions too broad"
  exit 1
fi

# Check 7: Verify pod-reader cannot access other resources
((TOTAL_CHECKS++))
if ! kubectl auth can-i get services -n rbac-test --as=system:serviceaccount:rbac-test:pod-reader; then
  echo "✅ pod-reader cannot access services in rbac-test namespace"
  ((PASS++))
else
  echo "❌ pod-reader can access services - permissions too broad"
  exit 1
fi

# Check 8: Verify no permissions in other namespaces
((TOTAL_CHECKS++))
if ! kubectl auth can-i get pods -n default --as=system:serviceaccount:rbac-test:pod-reader; then
  echo "✅ pod-reader has no permissions in default namespace"
  ((PASS++))
else
  echo "❌ pod-reader has permissions in the default namespace - too broad"
  exit 1
fi

# Final check
if [ "$PASS" -eq "$TOTAL_CHECKS" ]; then
  echo "🎉 All checks passed! Your RBAC configuration is correct."
  exit 0
else
  echo "❌ Some checks failed. Please review the output and try again."
  echo "$PASS out of $TOTAL_CHECKS checks passed."
  exit 1
fi
