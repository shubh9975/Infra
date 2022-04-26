# Jaeger Community Kubernetes Helm Charts

## Usage

Once Helm is set up properly, add the repo as follows:

```console
 helm repo add jaegertracing https://jaegertracing.github.io/helm-charts
```

You can then run `helm search repo jaegertracing` to see the charts.

Deploy upgraded chart with customize values (i.e jaeger-values.yaml)
Note: Always update chart repo

```console
helm repo update
 
<<<<<<< HEAD
helm upgrade --install jaeger -f kubernetes/helm-charts/jaeger/jaeger-values.yaml jaeger --namespace <namespace>
=======
#helm upgrade jaeger --install -f kubernetes/helm-charts/jaeger/jaeger-values.yaml jaegertracing/jaeger --namespace <namespace>
>>>>>>> 
```

