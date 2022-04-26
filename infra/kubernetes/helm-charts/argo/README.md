# Argo Community Kubernetes Helm Charts

## Usage

Once Helm is set up properly, add the repo as follows:

```console
helm repo add argo-cd https://argoproj.github.io/argo-helm
```

You can then run `helm search repo argo-cd` to see the charts.

Deploy upgraded chart with customize values (i.e argocd-values.yaml)
Note: Always update chart repo

```console
helm repo update
 
helm upgrade --install argocd -f kubernetes/helm-charts/argo/argocd-values.yaml argo-cd --namespace argo
```

