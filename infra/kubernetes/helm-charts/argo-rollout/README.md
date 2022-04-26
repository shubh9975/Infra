# Argo-Rollout Community Kubernetes Helm Charts

## Usage

Once Helm is set up properly, add the repo as follows:

```console
helm repo add argo https://argoproj.github.io/argo-helm
```

You can then run `helm search repo argo` to see the charts.

Deploy upgraded chart with customize values (i.e argorollout-values.yaml)
Note: Always update chart repo

```console
helm repo update
 
helm upgrade --install argorollout -f kubernetes/helm-charts/argo-rollout/argorollout-values.yaml argo-rollout --namespace argocd
```

