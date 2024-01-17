#!/bin/bash

IP_PROXY=( $(jq -r '.proxy[].ip' k8s-config.json) )

FILE_SERVICE="/etc/systemd/system/kubelet.service"
printf "\n\n-- Content of ${FILE_SERVICE}\n\n"

cat <<EOF | sudo tee ${FILE_SERVICE}
[Unit]
Description=Kubernetes Kubelet
After=docker.service
Requires=docker.service

[Service]
ExecStart=/opt/kubernetes/server/bin/kubelet \\
--hostname-override=$(hostname -s) \\
--api-servers=http://${IP_PROXY}:8080 \\
--logtostderr=true
Restart=on-failure
KillMode=process

[Install]
WantedBy=multi-user.target
EOF
