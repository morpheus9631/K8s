#!/bin/bash

# $1 is proxy server ip address
if [ "$1" == "" ]; then
  echo "Syntax: $0 [proxy server IP address]"
  exit 1
fi
PROXY_IP=$1

CA_DIR="keys"
if [ -d ${CA_DIR} ]; then
  echo "Directory of ${CA_DIR}/ exist ..."
  exit 1;
else
  mkdir -p "./${CA_DIR}"
fi

cd ${CA_DIR}
openssl genrsa -out ca.key 2048
openssl req -x509 -new -nodes -key ca.key -subj "/CN=${PROXY_IP}" -days 1000 -out ca.crt
openssl genrsa -out server.key 2048 
openssl req -new -key server.key -subj "/CN=${PROXY_IP}" -out server.csr
openssl x509 -req -in server.csr -CA ca.crt -CAkey ca.key -CAcreateserial -out server.crt -days 1000
openssl x509 -noout -text -in server.crt

