#!/bin/bash
# This script will install amazon-efs-utils on Ubuntu 20.04
# It has not been tested with other versions

echo "Downloading efs-utils repo..."
git clone https://github.com/aws/efs-utils
cd ./efs-utils

echo "Installing requirements for make..."
sudo apt-get install -y build-essential

echo "Installing binutils..."
sudo apt-get -y install binutils

echo "Building efs-utils..."
./build-deb.sh

echo "Installing efs-utils..."
sudo apt-get -y install ./build/amazon-efs-utils*deb

echo 'Cleaning up...'
cd ..
rm -rf ./efs-utils
sudo apt-get -y autoremove
sudo apt-get -y clean
