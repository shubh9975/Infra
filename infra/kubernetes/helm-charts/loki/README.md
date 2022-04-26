# Loki & Promtail Community Kubernetes Helm Charts

## Usage

Once Helm is set up properly, add the repo as follows:

```console
helm repo add grafana https://grafana.github.io/helm-charts
```

You can then run `helm search repo loki/promtail-community` to see the charts.
Deploy upgraded chart with customize values (i.e loki-values.yaml/promtail-values.yaml)
Note: Always update chart repo

```console
helm repo update
 

helm upgrade --install loki -f kubernetes/helm-charts/loki/loki-values.yaml grafana/loki-stack --namespace <namespace>
```
