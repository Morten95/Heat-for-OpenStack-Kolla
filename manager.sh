#!/bin/bash -v
tempdeb=$(mktemp /tmp/debpackage.XXXXXXXXXXXXXXXXXX) || exit 1

# For manager node
apt-get -y update
apt-get install -y python-pip
pip install -U pip

apt-get install -y python-dev libffi-dev gcc libssl-dev python-selinux python-setuptools

# Install ansible
echo **INSTALLING ANSIBLE**
echo **INSTALLING ANSIBLE**
apt-get install -y ansible
sudo -H pip install --ignore-installed PYYAML
pip install -U ansible
pip install kolla-ansible
apt update
# moving things around
echo *****MOVING THINGS ARROUND*****
echo *****MOVING THINGS ARROUND*****
cp -r /usr/local/share/kolla-ansible/etc_examples/kolla /etc/
cp /usr/local/share/kolla-ansible/ansible/inventory/* .

# Installing kolla and kolla-ansible repos
git clone https://github.com/openstack/kolla
git clone https://github.com/openstack/kolla-ansible

pip install -r kolla/requirements.txt
pip install -r kolla-ansible/requirements.txt

mkdir -p /etc/kolla
cp -r kolla-ansible/etc/kolla/* /etc/kolla
cp kolla-ansible/ansible/inventory/* .

kolla-genpwd

# Installing docker
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/
ubuntu$(lsb_release -cs) stable"


sudo apt-get update

apt-cache policy docker-ce
sudo apt-get install -y docker-ce

pip install -U docker-py
pip install -U docker
mkdir -p /etc/systemd/system/docker.service.d
cat <<EOF > /etc/systemd/system/docker.service.d/kolla.conf
[Service]
MountFlags=shared
EOF
systemctl daemon-reload
systemctl restart docker

apt-get -y install ntp
service libvirt-bin stop
update-rc.d libvirt-bin disable

