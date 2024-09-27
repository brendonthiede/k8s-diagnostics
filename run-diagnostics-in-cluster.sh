#!/bin/bash
set -x

NAMESPACE="${1:-"default"}"
IMAGE_TAG="${2:-"latest"}"

kubectl run k8s-diagnostics --namespace "${NAMESPACE}" --rm --restart=Never -i --tty --image "thiedebr/k8s-diagnostics:${IMAGE_TAG}" -- /bin/bash
