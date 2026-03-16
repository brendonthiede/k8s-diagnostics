# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

k8s-diagnostics is a container image and Helm chart for troubleshooting Kubernetes clusters. It packages a wide array of network, database, and system diagnostic tools into a hardened, non-root container.

## Key Commands

### Docker

```bash
# Build the image locally
docker build -t k8s-diagnostics .

# Build the nonroot variant (default target)
docker build --target nonroot -t k8s-diagnostics .
```

### Helm

```bash
# Lint the chart
helm lint charts/k8s-diagnostics

# Deploy via Helm
helm upgrade --install k8s-diagnostics charts/k8s-diagnostics --namespace <namespace>

# Deploy with EKS security groups
./k8s-diagnostics-helm-deploy.sh
```

### Quick Cluster Deployment

```bash
# Run as a temporary pod (no Helm)
./run-diagnostics-in-cluster.sh
```

## Architecture

### Docker Multi-Stage Build

The `Dockerfile` has two stages:

- **`root`**: Ubuntu 22.04 base installing all diagnostic tools (tcpdump, nmap, psql, redis-cli, sqlcmd, scapy, etc.). Adds `/opt/mssql-tools18/bin` to `PATH`. The apt cache (`/var/lib/apt/lists`) is intentionally retained so additional packages can be installed at runtime with `apt-get install`.
- **`nonroot`**: Builds from `root`, creates a `diagnostics` user (UID 10000) with passwordless sudo, and sets the default command to `tail -f /dev/null` to keep the container alive.

The final image is the `nonroot` stage.

### Helm Chart

`charts/k8s-diagnostics/` deploys the image as a single-replica Deployment with:

- Non-root security context (`runAsUser: 10000`, `runAsNonRoot: true`)
- All Linux capabilities dropped, seccomp set to `RuntimeDefault`
- Optional AWS EKS `SecurityGroupPolicy` via `pod_sg_policy.yaml` (enabled by setting `podSecurityGroupIds` in values)
- Optional `ServiceAccount` creation (disabled by default)

### CI/CD

Two GitHub Actions workflows:

- **`docker-publish.yml`**: Builds and pushes multi-platform images to Docker Hub (`thiedebr/k8s-diagnostics`) on pushes to `main` or semver tags (`v*.*.*`). Skips on README or chart-only changes.
- **`helm-publish.yml`**: Lints and releases the Helm chart via `chart-releaser` on pushes to `main`.

### Versioning

Chart version and app version in `charts/k8s-diagnostics/Chart.yaml` must be kept in sync. Docker image tags are driven by git tags matching `v*.*.*`.
