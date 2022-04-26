# Vault Community Kubernetes Helm Charts

## Usage

Once Helm is set up properly, add the repo as follows:

```console
helm repo add hashicorp https://helm.releases.hashicorp.com
```

You can then run `helm search repo hashicorp/vault` to see the charts.

Deploy upgraded chart with customize values (i.e vault-values.yaml)
Note: Always update chart repo

```console
helm repo update


Deploy consule using helm

helm install consul hashicorp/consul --values helm-consul-values.yml --namespace <namespace>

Deploy vault using helm 

helm install vault hashicorp/vault --values helm-vault-values.yml --namespace <namespace>


#helm upgrade --install vault -f kubernetes/helm-charts/grafana/vault-values.yaml vault --namespace <namespace>
```
»Initialize and unseal Vault
kubectl exec vault-0 -- vault --namespace <namespace> operator init -key-shares=1 -key-threshold=1 -format=json > cluster-keys.json
cat cluster-keys.json | jq -r ".unseal_keys_b64[]" 
VAULT_UNSEAL_KEY=$(cat cluster-keys.json | jq -r ".unseal_keys_b64[]")
kubectl exec vault-1 -- vault operator unseal $VAULT_UNSEAL_KEY
