#!/bin/bash -v
tempdeb=$(mktemp /tmp/debpackage.XXXXXXXXXXXXXXXXXX) || exit 1

apt-get -y update
apt-get install -y python-pip
pip install -U pip
sudo -H pip install --ignore-installed PYYAML

