#!/bin/bash

if [ -z $1 ]; then
  echo "ETCD server 1 IP address not found ...]"
  exit 1;
fi
IP_ETCD=$1

clear
printf " Test etcd cluster:"
printf "\n\n  Server IP: "${IP_ETCD}
printf "\n\n    "
curl -L http://${IP_ETCD}:2379/v2/keys/test -XPUT -d value="awesome"
printf "\n    "
curl -L http://${IP_ETCD}:2379/v2/keys/test
printf "\n"









