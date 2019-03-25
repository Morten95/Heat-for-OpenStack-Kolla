##!/bin/bash
#set -xe
#
## Fremgangsmåte for å sette opp k8s cluster
#sudo apt-get update
#sudo apt-get install --no-install-recommends -y \
#        ca-certificates \
#        git \
#        make \
#        jq \
#        nmap \
#        curl \
#        uuid-runtime
#
#
## Making the node ready for k8s
#
#
#sudo apt install docker.io -y
#sudo systemctl start docker
#sudo systemctl enable docker
#
## Anbefalt av Edureka
#sudo apt-get install -y openssh-server 
#
## Kubectl, kubeadmin, kubelet and their dependencies
#sudo apt-get update && apt-get install -y apt-transport-https curl
#sudo curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
#sudo cat <<EOF >/etc/apt/sources.list.d/kubernetes.list
#deb https://apt.kubernetes.io/ kubernetes-xenial main
#EOF
#sudo apt-get update
#sudo apt-get install -y kubelet kubeadm kubectl
##apt-mark hold kubelet kubeadm kubectl
#
#sudo swapon -s
#sudo swapoff -a
