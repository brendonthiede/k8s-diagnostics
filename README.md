# k8s-diagnostics

Container for troubleshooting a Kubernetes cluster

For latest documentation, see [the GitHub repository](https://github.com/brendonthiede/k8s-diagnostics).

## Running as a pod

To deploy the container as a pod in the default namespace, run the following command:

```bash
kubectl run k8s-diagnostics --rm --restart=Never -i --tty --image "thiedebr/k8s-diagnostics:latest" -- /bin/bash
```

## Deploying as a Helm chart

To deploy as a Helm chart in the default namespace, run the following command:

```bash
helm upgrade --install k8s-diagnostics https://github.com/brendonthiede/k8s-diagnostics/releases/download/k8s-diagnostics-1.0.5/k8s-diagnostics-1.0.5.tgz
```
