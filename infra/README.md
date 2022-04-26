# README #

This README would normally document whatever steps are necessary to get your application up and running.

### What is this repository for? ###

* Infra repository containes the ansible roles playbooks/roles to deploy or install infra as well service applications in local system as well as kubernetes environment
* applications that will install/deploy in local system
> 1. Jenkins
> 2. Haproxy
> 3. Nexus artifactory
> 4. Sonarqube
> 5. Trivy
* To install above application we created ansible roles in **'ansible/roles'** location

> 1. For Jenkins installation:
>    ansible-playbook -i inventory playbook-setup-jenkins.yaml
> 2. For nexus installation:
>    ansible-playbook -i inventory playbook-setup-nexus.yaml
> 3. For sonarqube installation:
>    ansible-playbook -i inventory playbook-setup-sonarqube.yaml
> 4. For haproxy(loadbalancer) installation:
>    ansible-playbook -i inventory playbook-setup-haproxy.yaml
> 5. For trivy installation:
>    ansible-playbook -i inventory playbook-setup-trivy.yaml
>Note: to execute dry-run use (--check) flag

* applications that will install/deploy in Kubernetes environment
> 1. Helm, Kubectl
> 2. Longhorn
> 3. Metallb
> 4. Nginx ingress
> 5. ArgoCD
> 5. Keycloak
> 6. Prometheus
> 7. Loki
> 8. Jaeger
> 9. Grafana
> 10. Valut
> 11. Cert-manager
> 12. Pulser
> 13. Cadance
> 14. velero

* To install/uninstall application in kubernetes environment we created ansible role name under **'utilities/roles/kubernetes-app'**

> For install use below command:
> ansible-playbook playbook-setup-kubernetesapp.yml --tags install_<name_of_application> 

> For Dry run (i.e only give you output not get deployed)
> ansible-playbook playbook-setup-kubernetesapp.yml --tags install_<name_of_application> --check

> For uninstall (i.e to remove application from cluster):
> ansible-playbook playbook-setup-kubernetesapp.yml --tags uninstall_<name_of_application> 

> For installation of all applications give in above list
> ansible-playbook playbook-setup-kubernetesapp.yml --tags install

> For uninstallation of all applications give in above list
> ansible-playbook playbook-setup-kubernetesapp.yml --tags uninstall