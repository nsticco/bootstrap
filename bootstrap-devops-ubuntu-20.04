#!/bin/bash
# This script will install DevOps tools on Ubuntu 20.04
# It has not been tested with other versions

KUBECTL_VERSION="1.17"

echo "Installing fundamental development tools..."
sudo apt install -y python3 python3-pip nodejs npm git default-jdk unzip

echo "Installing AWS CLI v2..."
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install

echo "Installing kubectl $KUBECTL_VERSION..."
sudo apt-get update && sudo apt-get install -y apt-transport-https gnupg2
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee -a /etc/apt/sources.list.d/kubernetes.list
sudo apt-get update -y
sudo apt-get install -y kubectl=$KUBECTL_VERSION*




echo "Cleaning up after bootstrapping..."
sudo apt-get -y autoremove
sudo apt-get -y clean
