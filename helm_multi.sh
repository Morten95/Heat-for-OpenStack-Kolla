#!/bin/bash
set -xe
cat <<EOF >> /home/ubuntu/.ssh/authorized_keys
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDBJRiXTpatyOCwAvb9ZRyNfquKJdpLJVkuYD4sMCAI1MiACPqQMos0e2efEu/fzCgNluIg5L5tERsweBzTtQraTRTgXhwaP1Nj5lDaSfiFBlx5KzPm9fsN9KMB3yxbX8xraMLrK/xNjgy+gqX2G0dwnY4/EUdj+npRNzf3uBY6jFaw3FD/Q1LiqA8rE9gRzKQOD8EbBF++3A+FYx/fzrL9Dx6td1K6IoWBA/O8azCYhYMf+HEmxCKA36yabGv97XmNxX8aDJPGGYePdXIZQ0lpOWZpP6zRnm2cgOHLD7A84rzXjFlA0uqVhwRjEJzvsnsnlXGl6c9MsioxZsHnQ3eD morten@morten-VirtualBox
EOF


sudo apt-get update
sudo apt-get install --no-install-recommends -y \
        ca-certificates \
        git \
        make \
        jq \
        nmap \
        curl \
        uuid-runtime

#
## Making the node ready for k8s
## Kubernetes bruker hostname og trenger statisk ip
## sudo apt update
## tee <<EOF >> /etc/hosts
## 192.168.51.202 hkeystone
## 192.168.51.205 hnova
## 192.168.51.214 hmanager
## EOF
#
sudo apt install docker.io -y
sudo systemctl start docker
sudo systemctl enable docker

#sudo apt-get update
#sudo apt-get install --no-install-recommends -y git
#sudo chown -R ubuntu: /opt
#git clone https://git.openstack.org/openstack/openstack-helm-infra.git /opt/openstack-helm-infra
#git clone https://git.openstack.org/openstack/openstack-helm.git /opt/openstack-helm

# Kubectl, kubeadmin, kubelet and their dependencies
sudo apt-get update && sudo apt-get install -y apt-transport-https
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee -a /etc/apt/sources.list.d/kubernetes.list
sudo apt-get update
sudo apt install -y kubeadm kubelet kubectl

sudo swapon -s
sudo swapoff -a
sudo apt-get install -y ca-certificates git make jq nmap curl uuid-runtime

git clone https://github.com/openstack/openstack-helm-infra.git
git clone https://github.com/openstack/openstack-helm.git
cd /openstack-helm
./tools/deployment/developer/common/010-deploy-k8s.sh
sleep 300
./tools/deployment/developer/common/020-setup-client.sh
sleep 300
./tools/deployment/developer/common/030-ingress.sh
sleep 300
./tools/deployment/developer/nfs/040-nfs-provisioner.sh
sleep 300
./tools/deployment/developer/nfs/050-mariadb.sh
sleep 300
./tools/deployment/developer/nfs/070-memcached.sh
sleep 300
./tools/deployment/developer/nfs/080-keystone.sh
sleep 300
./tools/deployment/developer/nfs/090-heat.sh
sleep 300
./tools/deployment/developer/nfs/100-horizon.sh
sleep 300
./tools/deployment/developer/nfs/120-glance.sh
sleep 300
./tools/deployment/developer/nfs/140-openvswitch.sh
sleep 300
./tools/deployment/developer/nfs/150-libvirt.sh
sleep 300
./tools/deployment/developer/nfs/160-compute-kit.sh
sleep 300
./tools/deployment/developer/nfs/170-setup-gateway.sh

