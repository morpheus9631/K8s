#!/bin/bash

IP_PROXY=( $(jq -r '.proxy[].ip' k8s-config.json) )
echo "Proxy IP: "${IP_PROXY}

FILE_TARGET="/etc/systemd/system/kube-proxy.service"
printf "\n\n-- Content of ${FILE_TARGET}\n\n"

cat <<EOF | sudo tee ${FILE_TARGET}
[Unit]
Description=Kubernetes Proxy
After=network.target

[Service]
ExecStart=/opt/kubernetes/server/bin/kube-proxy \\
--hostname-override=$(hostname -s) \\
--master=http://${IP_PROXY}:8080 \\
--logtostderr=true
Restart=on-failure

[Install]
WantedBy=multi-user.target
EOF
