#!/bin/bash -v
tempdeb=$(mktemp /tmp/debpackage.XXXXXXXXXXXXXXXXXX) || exit 1

apt-get -y update
apt-get install -y python-pip
pip install -U pip
sudo -H pip install --ignore-installed PYYAML

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

echo "Done!!" >> /home/ubuntu/log.txt
echo "Done!!" >> /home/ubuntu/log.txt


echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDBJRiXTpatyOCwAvb9ZRyNfquKJdpLJVkuYD4sMCAI1MiACPqQMos0e2efEu/fzCgNluIg5L5tERsweBzTtQraTRTgXhwaP1Nj5lDaSfiFBlx5KzPm9fsN9KMB3yxbX8xraMLrK/xNjgy+gqX2G0dwnY4/EUdj+npRNzf3uBY6jFaw3FD/Q1LiqA8rE9gRzKQOD8EbBF++3A+FYx/fzrL9Dx6td1K6IoWBA/O8azCYhYMf+HEmxCKA36yabGv97XmNxX8aDJPGGYePdXIZQ0lpOWZpP6zRnm2cgOHLD7A84rzXjFlA0uqVhwRjEJzvsnsnlXGl6c9MsioxZsHnQ3eD morten@morten-VirtualBox" >> /home/ubuntu/.ssh/authorized_keys
