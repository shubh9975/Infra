#!/bin/bash

echo "Choose an option:"
echo "1. Install Docker and Kubeadm & Helm "
echo "2. Uninstall Docker and Kubeadm & Helm"
echo "3. Install Docker"
echo "4. Uninstall Docker"
echo "5. Install Kubeadm"
echo "6. Uninstall Kubeadm"
echo "7. Install Helm"
echo "8. Uninstall helm"
read -p "Enter your choice (1-8): " choice

case $choice in
    1)
        echo "Installing Docker and Kubeadm & Helm"
        # Installation of Docker and Kubeadm script goes here
        # Docker installation commands
        sudo apt update
        sudo apt install apt-transport-https ca-certificates curl software-properties-common
        curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
        echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
        sudo apt update
        sudo apt install docker-ce docker-ce-cli containerd.io
        sudo systemctl enable docker
        sudo systemctl start docker
        sudo systemctl restart docker
        sleep 5

        # Kubeadm installation commands
        sudo apt update -y
        sudo apt upgrade -y
        curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add
        sudo apt-add-repository "deb https://apt.kubernetes.io/ kubernetes-xenial main"
        sudo apt-get install kubeadm kubelet kubectl -y
        sudo apt-mark hold kubeadm kubelet kubectl
        sudo swapoff -a
        sudo systemctl restart containerd
        sudo ufw allow 6443/tcp
        sudo ufw allow 2379/tcp
        sudo ufw allow 2380/tcp
        sudo ufw allow 10250/tcp
        sudo ufw allow 10251/tcp
        sudo ufw allow 10252/tcp
        sudo ufw allow 10255/tcp
        sudo ufw allow 6783/tcp
        sudo ufw allow 6783/udp
        sudo ufw allow 6784/tcp
        sudo rm /etc/containerd/config.toml
        sudo systemctl restart containerd
        sleep 5
        sudo kubeadm init --pod-network-cidr=10.95.0.0/16
        sleep 5
        mkdir -p $HOME/.kube
        sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
        sudo chown $(id -u):$(id -g) $HOME/.kube/config
        curl https://raw.githubusercontent.com/projectcalico/calico/v3.25.0/manifests/calico.yaml -O
        kubectl apply -f calico.yaml
        export KUBECONFIG="/etc/kubernetes/admin.conf"
        sudo chmod -R 666 /etc/kubernetes/admin.conf

        # Installing Helm
        curl https://baltocdn.com/helm/signing.asc | gpg --dearmor | sudo tee /usr/share/keyrings/helm.gpg > /dev/null
        sudo apt-get install apt-transport-https --yes
        echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/helm.gpg] https://baltocdn.com/helm/stable/debian/ all main" | sudo tee /etc/apt/sources.list.d/helm-stable-debian.list
        sudo apt-get update
        sudo apt-get install helm
        ;;

    2)
        echo "Uninstalling Docker and Kubeadm & Helm"
        # Uninstallation of Docker and Kubeadm script goes here
        # Docker uninstallation commands
        sudo apt-get purge -y docker-engine docker docker.io docker-ce docker-ce-cli
        sudo apt-get autoremove -y --purge docker-engine docker docker.io docker-ce
        sudo rm -rf /var/lib/docker /etc/docker
        sudo rm /etc/apparmor.d/docker
        sudo groupdel docker
        sudo rm -rf /var/run/docker.sock

        # Kubeadm uninstallation commands
        kubeadm reset
        sudo apt-get purge kubeadm kubectl kubelet kubernetes-cni kube*
        sudo apt-get autoremove
        sudo rm -rf ~/.kube

        # Helm Uninstallation commands
        sudo apt-get purge helm -y
        ;;

    3)
        echo "Installing Docker..."
        # Installation of Docker script goes here
        sudo apt update
        sudo apt install apt-transport-https ca-certificates curl software-properties-common
        curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
        echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
        sudo apt update
        sudo apt install docker-ce docker-ce-cli containerd.io
        sudo systemctl enable docker
        sudo systemctl start docker
        sudo systemctl restart docker
        sleep 5
        ;;

    4)
        echo "Uninstalling Docker..."
        # Uninstallation of Docker script goes here
        sudo apt-get purge -y docker-engine docker docker.io docker-ce docker-ce-cli
        sudo apt-get autoremove -y --purge docker-engine docker docker.io docker-ce
        sudo rm -rf /var/lib/docker /etc/docker
        sudo rm /etc/apparmor.d/docker
        sudo groupdel docker
        sudo rm -rf /var/run/docker.sock
        ;;

    5)
        echo "Installing Kubeadm..."
        # Installation of Kubeadm script goes here
        sudo apt update -y
        sudo apt upgrade -y
        curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add
        sudo apt-add-repository "deb https://apt.kubernetes.io/ kubernetes-xenial main"
        sudo apt-get install kubeadm kubelet kubectl -y
        sudo apt-mark hold kubeadm kubelet kubectl
        sudo swapoff -a
        sudo systemctl restart containerd
        sudo ufw allow 6443/tcp
        sudo ufw allow 2379/tcp
        sudo ufw allow 2380/tcp
        sudo ufw allow 10250/tcp
        sudo ufw allow 10251/tcp
        sudo ufw allow 10252/tcp
        sudo ufw allow 10255/tcp
        sudo ufw allow 6783/tcp
        sudo ufw allow 6783/udp
        sudo ufw allow 6784/tcp
        sudo rm /etc/containerd/config.toml
        sudo systemctl restart containerd
        sleep 5
        sudo kubeadm init --pod-network-cidr=10.95.0.0/16
        sleep 5
        mkdir -p $HOME/.kube
        sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
        sudo chown $(id -u):$(id -g) $HOME/.kube/config
        curl https://raw.githubusercontent.com/projectcalico/calico/v3.25.0/manifests/calico.yaml -O
        kubectl apply -f calico.yaml

        export KUBECONFIG="/etc/kubernetes/admin.conf"
        sudo chmod -R 666 /etc/kubernetes/admin.conf
        ;;

    6)
        echo "Uninstalling Kubeadm..."
        # Uninstallation of Kubeadm script goes here
        kubeadm reset
        sudo apt-get purge kubeadm kubectl kubelet kubernetes-cni kube*
        sudo apt-get autoremove
        sudo rm -rf ~/.kube
        ;;

    7)
        echo "Installing Helm..."
        # Installing Helm
        curl https://baltocdn.com/helm/signing.asc | gpg --dearmor | sudo tee /usr/share/keyrings/helm.gpg > /dev/null
        sudo apt-get install apt-transport-https --yes
        echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/helm.gpg] https://baltocdn.com/helm/stable/debian/ all main" | sudo tee /etc/apt/sources.list.d/helm-stable-debian.list
        sudo apt-get update
        sudo apt-get install helm
        ;;

    8)
        echo "Uninstalling Helm..."
        # Uninstalling Helm
        sudo apt-get purge helm -y
        ;;

    *)
        echo "Invalid choice. Exiting..."
        exit 1
        ;;
esac
