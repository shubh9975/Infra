# MetalLB Community Kubernetes Helm Charts

## Usage

Once Helm is set up properly, add the repo as follows:

```console
helm repo add metallb https://metallb.github.io/metallb
```

You can then run `helm search repo metallb` to see the charts.

Deploy upgraded chart with customize values (i.e metallb-values.yaml)
Note: Always update chart repo

```console
helm repo update
 
helm upgrade --install metallb -f kubernetes/helm-charts/metalLB/metallb-values.yaml metallb --namespace <namespace>
```

