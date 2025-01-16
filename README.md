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
helm upgrade --install k8s-diagnostics https://github.com/brendonthiede/k8s-diagnostics/releases/download/k8s-diagnostics-1.1.3/k8s-diagnostics-1.1.3.tgz
```

Or to deploy to EKS, leveraging VPC Security Groups:

```bash
helm upgrade --install k8s-diagnostics https://github.com/brendonthiede/k8s-diagnostics/releases/download/k8s-diagnostics-1.1.3/k8s-diagnostics-1.1.3.tgz --set "podSecurityGroupIds={sg-000aaabbbcccddeff,sg-111aaabbbcccddeff}"
```

Once the pod is up and running you can exec into it. The Helm deployment should give you a command that you can copy and paste to do so, but for the default namespace, it could look something like this:

```bash
kubectl exec -it $(kubectl get po -l app.kubernetes.io/instance=k8s-diagnostics -o name) -- /bin/bash
```

Also keep in mind that this deployment will not clean up after itself, so once you are done you will need to run `helm uninstall`. For a deployment in the default namespace you can run:

```bash
helm uninstall k8s-diagnostics
```

## GitHub Actions

### Helm Chart Release

To release a new version of the Helm chart, simply update the version in the `Chart.yaml` file and push the changes to the `main` branch. GitHub Actions will automatically build and release the new version of the Helm chart.

### Container Image Release

To update the container image in Docker Hub, simply push a new tag to the `main` branch in the form `v.#.#.#`. GitHub Actions will automatically build and release the new version of the container image with the tag provided and `latest`. Any push to main will also trigger a build and release of the `main` tag.
