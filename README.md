# k8s-diagnostics

Container for troubleshooting a Kubernetes cluster

## Running as a pod

To deploy the container as a pod in the default namespace, run the following command:

```bash
kubectl run k8s-diagnostics --rm --restart=Never -i --tty --image "thiedebr/k8s-diagnostics:latest" -- /bin/bash
```

## Deploying as a Helm chart

To deploy as a Helm chart in the default namespace, run the following command:

```bash
helm upgrade --install k8s-diagnostics https://github.com/brendonthiede/k8s-diagnostics/releases/download/k8s-diagnostics-1.1.1/k8s-diagnostics-1.1.1.tgz
```

Or to deploy to EKS, leveraging VPC Security Groups:

```bash
helm upgrade --install k8s-diagnostics https://github.com/brendonthiede/k8s-diagnostics/releases/download/k8s-diagnostics-1.1.1/k8s-diagnostics-1.1.1.tgz --set "podSecurityGroupIds={sg-000aaabbbcccddeff,sg-111aaabbbcccddeff}"
```

Once the pod is up and running you can exec into it. The Helm deployment should give you a command that you can copy and paste to do so, but for the default namespace, it could look something like this:

```bash
kubectl exec -it $(kubectl get po -l app.kubernetes.io/instance=k8s-diagnostics -o name) -- /bin/bash
```

Also keep in mind that this deployment will not clean up after itself, so once you are done you will need to run `helm uninstall`. For a deployment in the default namespace you can run:

```bash
helm uninstall k8s-diagnostics
```
