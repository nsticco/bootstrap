#!/bin/bash

if ! command -v "packer" &> /dev/null
then
  echo "Packer could not be found."
  PACKER_VERSION="1.6.1"
  echo "Installing Packer $PACKER_VERSION..."
  curl -o packer.zip https://releases.hashicorp.com/packer/${PACKER_VERSION}/packer_${PACKER_VERSION}_linux_amd64.zip
  unzip packer.zip
  sudo mv packer /usr/local/bin/packer
  rm packer.zip
fi

packer build ./packer-docker-ubuntu-20.04.json