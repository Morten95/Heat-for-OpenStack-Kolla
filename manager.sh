#!/bin/bash -v
# tempdeb=$(mktemp /tmp/debpackage.XXXXXXXXXXXXXXXXXX) || exit 1

# For manager node
cd /root/
if [ $(pwd) -ne '/root']; then
	echo "we are not in root folder, instead we are in $(pwd)" >> /home/ubuntu/log.txt
	exit
fi

echo "logfil for manager commando" >> /home/ubuntu/log.txt
sudo apt-get -y update
echo "apt-get -y update" >> /home/ubuntu/log.txt
sudo apt-get install -y python-pip
echo "apt-get install -y"  >> /home/ubuntu/log.txt
sudo pip install -U pip
echo "pip install -U pip" >> /home/ubuntu/log.txt

sudo apt-get install -y python-dev libffi-dev gcc libssl-dev python-selinux python-setuptools
echo "apt-get install -y python-dev libffi-dev gcc libssl-dev python-selinux python-setuptools" >> /home/ubuntu/log.txt
# Install ansible
echo **INSTALLING ANSIBLE**
echo **INSTALLING ANSIBLE**
sudo pip install -U ansible==2.4
echo "pip install -U ansible==2.4" >> /home/ubuntu/log.txt
sudo apt-get install -y ansible==2.4
echo "apt-get install -y ansible==2.4"  >> /home/ubuntu/log.txt
sudo -H pip install --ignore-installed PYYAML
echo "sudo -H pip install --ignore-installed PYYAML" >> /home/ubuntu/log.txt
sudo pip install kolla-ansible
echo "pip install kolla-ansible" >> /home/ubuntu/log.txt
sudo apt update 
echo "apt update" >> /home/ubuntu/log.txt
# moving things around
echo *****MOVING THINGS ARROUND***** >> /home/ubuntu/log.txt
cp -r /usr/local/share/kolla-ansible/etc_examples/kolla /etc/
echo "cp -r /usr/local/share/kolla-ansible/etc_examples/kolla /etc/" >> /home/ubuntu/log.txt
cp -r /usr/local/share/kolla-ansible/ansible/inventory/* /root/
echo "cp /usr/local/share/kolla-ansible/ansible/inventory/* ." >> /home/ubuntu/log.txt
# Installing kolla and kolla-ansible repos
echo "Installing kolla and kolla-ansible repos" >> /home/ubuntu/log.txt
git clone https://github.com/openstack/kolla
sudo mv -r kolla  /root/
echo "git clone https://github.com/openstack/kolla" >> /home/ubuntu/log.txt
git clone https://github.com/openstack/kolla-ansible 
sudo mv -r kolla-ansible /root/
echo "git clone https://github.com/openstack/kolla-ansible" >> /home/ubuntu/log.txt

sudo pip install -r /root/kolla/requirements.txt
echo "pip install -r kolla/requirements.txt" >>  /home/ubuntu/log.txt
sudo pip install -r /root/kolla-ansible/requirements.txt
echo "pip install -r kolla-ansible/requirements.txt" >>  /home/ubuntu/log.txt
sudo mkdir -p /etc/kolla
echo "mkdir -p /root/etc/kolla" >>  /home/ubuntu/log.txt
sudo cp -r /root/kolla-ansible/etc/kolla/* /etc/kolla
echo "cp -r kolla-ansible/etc/kolla/* /etc/kolla" /home/ubuntu/log.txt
sudo cp -r /root/kolla-ansible/ansible/inventory/* /root/
echo "cp kolla-ansible/ansible/inventory/* ." >> /home/ubuntu/log.txt

kolla-genpwd
echo "kolla-genpwd" >> /home/ubuntu/log.txt

# Installing docker
echo "installing docker" >> /home/ubuntu/log.txt
sudo curl -sSL https://get.docker.io | bash
sudo apt-get upgrade -y docker
sudo apt-get update

sudo apt-cache policy docker-ce
sudo apt-get install -y docker-ce

sudo apt-get upgrade docker-engine
echo "sudo apt-get upgrade docker-engine" >>  /home/ubuntu/log.txt
echo $(docker --version) >>  /home/ubuntu/log.txt
sudo pip install -U docker-py
sudo pip install -U docker
sudo mkdir -p /etc/systemd/system/docker.service.d
cat <<EOF > /etc/systemd/system/docker.service.d/kolla.conf
[Service]
MountFlags=shared
EOF
sudo systemctl daemon-reload
sudo systemctl restart docker

sudo apt-get -y install ntp
echo "install ntp" >> /home/ubuntu/log.txt
sudo service libvirt-bin stop
sudo update-rc.d libvirt-bin disable

echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDBJRiXTpatyOCwAvb9ZRyNfquKJdpLJVkuYD4sMCAI1MiACPqQMos0e2efEu/fzCgNluIg5L5tERsweBzTtQraTRTgXhwaP1Nj5lDaSfiFBlx5KzPm9fsN9KMB3yxbX8xraMLrK/xNjgy+gqX2G0dwnY4/EUdj+npRNzf3uBY6jFaw3FD/Q1LiqA8rE9gRzKQOD8EbBF++3A+FYx/fzrL9Dx6td1K6IoWBA/O8azCYhYMf+HEmxCKA36yabGv97XmNxX8aDJPGGYePdXIZQ0lpOWZpP6zRnm2cgOHLD7A84rzXjFlA0uqVhwRjEJzvsnsnlXGl6c9MsioxZsHnQ3eD morten@morten-VirtualBox" >> /home/ubuntu/.ssh/authorized_keys

echo "Done!!" >> /home/ubuntu/log.txt


