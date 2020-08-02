#!/bin/bash

# This is an example command to help you find AWS AMI Marketplace details
# Note that you can also chain commands for the same field, e.g.:
# --filters "Name=name,Values=*ubuntu*" "Name=name,Values=*20.04*"

aws ec2 describe-images \
  --region us-west-2 \
  --filters "Name=name,Values=*ubuntu-focal-20.04-amd64-server*"