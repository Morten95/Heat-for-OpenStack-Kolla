#!/bin/bash
set -xe

sudo apt-get update
sudo apt-get install --no-install-recommends -y \
        ca-certificates \
        git \
        make \
        jq \
        nmap \
        curl \
        uuid-runtime


# Making the node ready for k8s
# Kubernetes bruker hostname og trenger statisk ip
# sudo apt update
# tee <<EOF >> /etc/hosts
# 192.168.51.202 hkeystone
# 192.168.51.205 hnova
# 192.168.51.214 hmanager
# EOF

sudo apt install docker.io -y
sudo systemctl start docker
sudo systemctl enable docker


# Kubectl, kubeadmin, kubelet and their dependencies
#sudo apt-get update && sudo apt-get install -y apt-transport-https
#curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
#echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee -a /etc/apt/sources.list.d/kubernetes.list
#sudo apt-get update
#sudo apt install -y kubeadm kubelet kubectl
#
#sudo swapon -s
#sudo swapoff -a
