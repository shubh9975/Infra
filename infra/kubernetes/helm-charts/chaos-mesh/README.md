# Chaos Community Kubernetes Helm Charts

## Usage

Once Helm is set up properly, add the repo as follows:

```console
helm repo add chaos-mesh https://charts.chaos-mesh.org
```

You can then run `helm search repo chaos-mesh` to see the charts.

Deploy upgraded chart with customize values (i.e chaos-values.yaml)
Note: Always update chart repo

```console
helm repo update
 
helm upgrade --install chaos-mesh -f kubernetes/helm-charts/chaos/chaos-values.yaml chaos --namespace <namespace>
```

