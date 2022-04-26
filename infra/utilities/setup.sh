#!/bin/bash
RED='\033[0;31m'      
GREEN='\033[0;32m'        
YELLOW='\033[0;33m'       
BLUE='\033[0;34m'
WHITE='\033[0;37m'
NAMESPACE_NAME="adapt"
VALUES_PATH="../kubernetes/helm-charts"
LOG_FILE_PATH="/var/log/adapt.log"

log(){
   $@ &>> $LOG_FILE_PATH
}

utility_setup() {
	local HELM_INSTALLATION_URL="https://get.helm.sh/helm-v3.7.1-linux-amd64.tar.gz"
        echo -e "${GREEN}Installing helm..${WHITE}"
	log wget $HELM_INSTALLATION_URL
	log tar -xvzf helm-v3.7.1-linux-amd64.tar.gz
        log cp -r linux-amd64/helm /usr/local/bin
	log rm -rf helm-v3.7.1-linux-amd64.tar.gz 
	log rm -rf linux-amd64
        echo -e "${GREEN}Installing kubectl..${WHITE}"
        log curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
        log rm -rf kubectl
}
check_kubeconfig() {
        echo -e "${YELLOW}Verifying kubeconfig is present..${WHITE}"
        env | grep KUBECONFIG
        if [ $? -eq 0 ]; then
            echo -e "${GREEN}Kubeconfig is present${WHITE}"
        else
            echo -e "${RED}Kubeconfig is not present..${WHITE}"
            exit
        fi
}

k3s_setup() { 
     GET_K3S=$(k3s --version) 
     if [ $? -eq 0 ]; then
        echo -e "${GREEN} k3s is present your system..${WHITE}"
     else
	echo "Installing k3s on system!"
        curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="--no-deploy traefik" sh -s -
     fi	


      
}

create_namespace() {
  GET_NAMESPACE=$(kubectl get namespace $NAMESPACE_NAME -o yaml | grep -o "phase: Active")
  if [ $? -eq 0 ]; then
      echo -e "${YELLOW}namespace already present!${WHITE}"
  else
      echo -e "${GREEN}creating namespace..${WHITE}"
      kubectl create namespace $NAMESPACE_NAME
  fi

}

helm_repo_addition(){

       local PROMETHEUS="prometheus-community https://prometheus-community.github.io/helm-charts"
       local PLG="grafana https://grafana.github.io/helm-charts"
       local JAEGER="jaegertracing https://jaegertracing.github.io/helm-charts"
       local VAULT="hashicorp https://helm.releases.hashicorp.com"
       local CERT_MANAGER="jetstack https://charts.jetstack.io"
       local METALLB="metallb https://metallb.github.io/metallb"
       local INGRESS="nginx-stable https://helm.nginx.com/stable"
       local ARGOCD="argo-cd https://argoproj.github.io/argo-helm"
       local CHAOS_MESH="chaos-mesh https://charts.chaos-mesh.org"
       local MINIO="helm repo add minio https://charts.min.io/"
       local VELERO="stable https://charts.helm.sh/stable"
      

stack=("$PROMETHEUS" "$PLG" "$JAEGER" "$VAULT" "$CERT_MANAGER" "$METALLB" "$INGRESS" "$ARGOCD" "$CHAOS_MESH" "$MINIO" "$VELERO")
for val in "${stack[@]}"
do
        helm repo add $val

done
}

monitoring_loging(){
  echo -e "${BLUE}Installing monitoring stack..${WHITE}"	
  log helm upgrade --install prometheus -f $VALUES_PATH/prometheus/prometheus-values.yaml prometheus-community/prometheus --namespace $NAMESPACE_NAME
  log helm upgrade --install loki -f $VALUES_PATH/loki/loki-values.yaml grafana/loki-stack --namespace $NAMESPACE_NAME
} 

tracing(){
  echo -e "${BLUE}Installing jaeger..${WHITE}"
  log helm upgrade --install jaeger -f $VALUES_PATH/jaeger/jaeger-values.yaml jaegertracing/jaeger --namespace $NAMESPACE_NAME

}

secret_manager(){
  echo -e "${BLUE}Installing Vault & Cert Manager..${WHITE}"
  log helm upgrade --install consul -f $VALUES_PATH/vault/helm-consul-values.yml hashicorp/consul --namespace $NAMESPACE_NAME
  log helm upgrade --install vault -f  $VALUES_PATH/vault/vault-values.yaml hashicorp/vault --namespace $NAMESPACE_NAME
  log helm upgrade --install cert-manager -f $VALUES_PATH/cert-manager/certmanager-values.yaml jetstack/cert-manager --namespace $NAMESPACE_NAME
  
}

metalLB_nginx_controller(){
  echo -e "${BLUE}Installing metalLB as loadbalancer and nginx as ingress controller${WHITE}"
  log helm upgrade --install metallb -f $VALUES_PATH/metalLB/metallb-values.yaml metallb/metallb --namespace $NAMESPACE_NAME
  log helm upgrade --install nginx-ingress -f $VALUES_PATH/nginx-ingress/ingress-values.yaml nginx-stable/nginx-ingress --namespace $NAMESPACE_NAME
 
}

argo(){
  echo -e "${BLUE}Installing argocd and argorollout for continous deployment..${WHITE}"
  log helm upgrade --install argocd -f $VALUES_PATH/argo/argocd-values.yaml argo-cd/argo-cd --namespace $NAMESPACE_NAME
  log helm upgrade --install argorollout -f $VALUES_PATH/argo-rollout/argorollout.yaml argo-cd/argo-rollouts --namespace $NAMESPACE_NAME

}

chaos_testing(){
  echo -e "${BLUE}Installing chaos mesh for chaos testing..${WHITE}"
  log helm upgrade --install chaos-mesh -f $VALUES_PATH/chaos-mesh/chaos-values.yaml chaos-mesh/chaos-mesh --namespace $NAMESPACE_NAME

}

cluster_backup(){
  echo -e "${BLUE}Installing Velero and minio as backup and restore controller..${WHITE}"
  log helm upgrade --install  velero -f $VALUES_PATH/velero/velero-values.yaml stable/velero --namespace $NAMESPACE_NAME
  log helm upgrade --install  minio -f $VALUES_PATH/velero/minio-values.yaml minio minio/minio --namespace $NAMESPACE_NAME

}

reset(){
	echo -e "${GREEN}Cleaning up the cluster..${WHITE}"
        for release in $(helm ls --short --namespace $NAMESPACE_NAME)
	do
	   echo -e "${BLUE}Cleaning up the $release${WHITE}"
	   helm uninstall $release --namespace $NAMESPACE_NAME
	done
	echo -e "${BLUE}Deleting $NAMESPACE_NAME for clean up${WHITE}"
	log kubectl delete namespace $NAMESPACE_NAME --force
}
echo -e "${YELLOW}Select the choice of operation${WHITE}\n${GREEN}1) Setup cluster utilities${WHITE}\n${BLUE}2) Install application${WHITE}\n${RED}3) Cleanup cluster${WHITE}\n${GREEN}4)setup k3s kubernetes cluster ${WHITE}"
read choice
case $choice in
   "1")
       utility_setup
       check_kubeconfig
      ;;
   "2")
       create_namespace
       helm_repo_addition
       monitoring_loging
       tracing
       secret_manager
       metalLB_nginx_controller
       argo
       chaos_testing
       cluster_backup
      ;;
   "3")
       reset
      ;; 
   "4") 
       k3s_setup
      ;;
    *)
      echo "${RED}Wrong choice entered..${WHITE}"
      exit
     ;;
esac
