#!/usr/bin/env bash

SG_NAMESPACE_NAME="${1}"
DEPLOY_NAMESPACE_NAME="${2:-"default"}"

if [ -z "${SG_NAMESPACE_NAME}" ]; then
    SG_NAMESPACE_NAME="$(kubectl config view --minify | grep namespace | cut -d" " -f6)"
    if [ -z "${SG_NAMESPACE_NAME}" ]; then
        SG_NAMESPACE_NAME="default"
    fi
fi

SECURITY_GROUPS="$(kubectl get securitygrouppolicies.vpcresources.k8s.aws -n "${SG_NAMESPACE_NAME}" -o jsonpath='{.items[*].spec.securityGroups.groupIds[*]}' | tr ' ' '\n' | sort -u | paste -sd "," -)"

HELM_CHART_RELEASE="k8s-diagnostics-1.1.2"
HELM_CHART="https://github.com/brendonthiede/k8s-diagnostics/releases/download/${HELM_CHART_RELEASE}/${HELM_CHART_RELEASE}.tgz"

helm upgrade --install -n "${DEPLOY_NAMESPACE_NAME}" k8s-diagnostics "${HELM_CHART}" --set "podSecurityGroupIds={${SECURITY_GROUPS}}"

while ! kubectl get po -l app.kubernetes.io/instance=k8s-diagnostics -n "${DEPLOY_NAMESPACE_NAME}" | grep '1/1' >/dev/null; do
    sleep 1
done

sleep 2

echo "[INFO] Deleting pod to get security groups applied"
kubectl delete po -l app.kubernetes.io/instance=k8s-diagnostics -n "${DEPLOY_NAMESPACE_NAME}" --wait=true
while kubectl get po -l app.kubernetes.io/instance=k8s-diagnostics -n "${DEPLOY_NAMESPACE_NAME}" | grep 'Terminating' >/dev/null; do
    sleep 1
done

echo "[INFO] Waiting for pod to be recreated"
while ! kubectl get po -l app.kubernetes.io/instance=k8s-diagnostics -n "${DEPLOY_NAMESPACE_NAME}" | grep '1/1' >/dev/null; do
    sleep 1
done

kubectl exec -n "${DEPLOY_NAMESPACE_NAME}" -it "$(kubectl get po -l app.kubernetes.io/instance=k8s-diagnostics -n "${DEPLOY_NAMESPACE_NAME}" -o name)" -- /bin/bash
