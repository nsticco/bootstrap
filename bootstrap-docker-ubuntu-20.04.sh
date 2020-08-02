#!/bin/bash
# This script will install Docker and Docker Compose on Ubuntu 20.04
# It has not been tested with other versions
# It will setup Docker for the "ubuntu" user unless you pass a name as the first argument

if [ -z "$1" ]
then
  NAME="ubuntu"
else
  NAME=$1
fi

echo 'Removing Docker conflicts if present...'
sudo apt-get remove docker.io containerd runc
 
echo 'Running general updates...' 
sudo apt-get -y update

echo 'Installing fundamental Docker package requirements...' 
sudo apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common

echo 'Adding Docker repo...' 
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

echo 'Running general updates again...' 
sudo apt-get -y update

echo 'Installing Docker...' 
sudo apt-get install -y docker-ce docker-ce-cli containerd.io

echo 'Installing Docker Compose...' 
sudo curl -L "https://github.com/docker/compose/releases/download//docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

echo 'Adjusting user permissions...' 
sudo groupadd docker
sudo usermod -aG docker $NAME
 
echo 'Setting Docker to run at boot...'  
sudo systemctl enable docker

echo 'Cleaning up after bootstrapping...'
sudo apt-get -y autoremove
sudo apt-get -y clean
