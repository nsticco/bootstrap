#!/bin/bash
# This script will install DevOps tools on Ubuntu 20.04
# It has not been tested with other versions

# You can specify a kubectl version as the first CLI argument
if [ -z "$1" ]
then
  KUBECTL_VERSION="1.17"
else
  KUBECTL_VERSION=$1
fi

# You can specify a Terraform version as the second CLI argument
if [ -z "$2" ]
then
  TERRAFORM_VERSION="0.12.29"
else
  TERRAFORM_VERSION=$2
fi

# You can specify a Packer version as the third CLI argument
if [ -z "$3" ]
then
  PACKER_VERSION="1.6.1"
else
  PACKER_VERSION=$3
fi

echo "Installing fundamental development tools..."
sudo apt install -y python3 python3-pip nodejs npm git default-jdk unzip

echo "Installing AWS CLI v2..."
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
rm -f awscliv2.zip
rm -rf ./aws

echo "Installing kubectl $KUBECTL_VERSION..."
sudo apt-get update && sudo apt-get install -y apt-transport-https gnupg2
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
if grep -Fxq "deb https://apt.kubernetes.io/ kubernetes-xenial main" /etc/apt/sources.list.d/kubernetes.list
then
  echo "Not adding kubectl repo because it is already present"
else
  echo "Adding kubectl repo..."
  echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee -a /etc/apt/sources.list.d/kubernetes.list
fi
sudo apt-get update -y
sudo apt-get install -y kubectl=$KUBECTL_VERSION*

echo "Installing the latest Helm..."
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3
chmod 700 get_helm.sh
./get_helm.sh
rm ./get_helm.sh

echo "Installing Terraform $TERRAFORM_VERSION..."
curl -o terraform.zip https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip
unzip terraform.zip
sudo mv terraform /usr/local/bin/terraform
rm terraform.zip

echo "Installing Packer $PACKER_VERSION..."
curl -o packer.zip https://releases.hashicorp.com/packer/${PACKER_VERSION}/packer_${PACKER_VERSION}_linux_amd64.zip
unzip packer.zip
sudo mv packer /usr/local/bin/packer
rm packer.zip

echo "Cleaning up after bootstrapping..."
sudo apt-get -y autoremove
sudo apt-get -y clean
