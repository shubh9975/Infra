#!/bin/bash
INVENTORY="kube-inventory/kube-inv/inventory"
CLUSTER_CREATE_FILE="roles/kubernetes/cluster.yml"
CLUSTER_REMOVE_FILE="roles/kubernetes/reset.yml"
CLUSTER_UPGRADE_FILE="roles/kubernetes/upgrade-cluster.yml"
echo -e "Select the Operation\n1.Create cluster\n2.Remove cluster\n3.Upgrade cluster(Version)"
read choice
create(){
  echo -e "Deploying kubernetes HA cluster.."
  ansible-playbook -i "$INVENTORY" "$CLUSTER_CREATE_FILE" -e ansible_user=root -b --become-user=root
}
remove(){
  echo -e "Deleting kubernetes cluster.."
  ansible-playbook -i "$INVENTORY" "$CLUSTER_REMOVE_FILE" -e ansible_user=root -b --become-user=root
}
upgrade(){
   echo -e "Upgrading kubernetes cluster to latest version.."
   ansible-playbook -i "$INVENTORY" "$CLUSTER_UPGRADE_FILE" -e ansible_user=root -b --become-user=root
}
case $choice in
   "1")
      create
      ;;
   "2")
      remove
      ;;
   "3")
      upgrade
      ;;
   *)
     echo "No operation present"
     exit
     ;;
esac


