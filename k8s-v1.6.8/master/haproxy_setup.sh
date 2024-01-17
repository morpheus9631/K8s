#!/bin/bash

IP_MASTERS=( $(jq -r '.masters[].ip' k8s-config.json) )

#
# Build haproxy config file
#
FILE_TARGET="/opt/haproxy.cfg"

printf "\n\n-- Content of ${FILE_TARGET}\n\n"
cat <<EOF | sudo tee ${FILE_TARGET}
global
        log 127.0.0.1 local0
        log 127.0.0.1 local1 notice
        maxconn 4096
        maxpipes 1024
        daemon
defaults
        log     global
        mode    tcp
        option  tcplog
        option  dontlognull
        option  redispatch
        option http-server-close
        retries 3
        timeout connect 5000
        timeout client 50000
        timeout server 50000
frontend default_frontend
        bind *:8080
        default_backend master-cluster
backend master-cluster
        server master1 ${IP_MASTERS[0]}
        server master2 ${IP_MASTERS[1]}
EOF
echo ""
