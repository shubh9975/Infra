# Prometheus Community Kubernetes Helm Charts

## Usage

Once Helm is set up properly, add the repo as follows:

```console
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
```

You can then run `helm search repo prometheus-community` to see the charts.

Deploy upgraded chart with customize values (i.e prometheus-values.yaml)
Note: Always update chart repo

```console
helm repo update
 
helm upgrade --install prometheus -f kubernetes/helm-charts/prometheus/prometheus-values.yaml prometheus prometheus-community/prometheus --namespace <namespace>
```

