# nginx-ingress Community Kubernetes Helm Charts

## Usage

Once Helm is set up properly, add the repo as follows:

```console
helm repo add nginx-stable https://helm.nginx.com/stable
```

You can then run `helm search repo nginx-stable` to see the charts.

Deploy upgraded chart with customize values (i.e ingress-values.yaml)
Note: Always update chart repo

```console
helm repo update
 
helm upgrade --install  nginx-ingress -f kubernetes/helm-charts/ingress/ingress-values.yaml ingress --namespace <namespace>
```

