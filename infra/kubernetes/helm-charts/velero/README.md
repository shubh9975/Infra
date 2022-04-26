# Velero Community Kubernetes Helm Charts

## Usage

Once Helm is set up properly, add the repo as follows:

```console
helm repo add stable https://charts.helm.sh/stable  
```
#Minio repo
helm repo add minio https://charts.min.io/


You can then run `helm search repo stable` to see the charts.

Deploy upgraded chart with customize values (i.e velero-values.yaml)
Note: Always update chart repo

```console
helm repo update
 
helm upgrade --install  velero -f kubernetes/helm-charts/velero/velero-values.yaml velero stable/velero --namespace <namespace>
```

helm upgrade --install  minio -f kubernetes/helm-charts/velero/minio-values.yaml minio minio/minio --namespace <namespace>

