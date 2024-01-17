#!/bin/bash

if [ -z $1 ]; then
  echo "Server IP address not found ..."
  exit 1
fi
SRV_IP=$1

if [ -z $2 ]; then
  echo "Directory of keys not found ..."
  exit 1;
fi
DIR_KEYS=$2

scp -r  ${SRV_IP}:/srv/kubernetes/keys/"

