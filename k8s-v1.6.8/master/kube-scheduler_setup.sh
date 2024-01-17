#!/bin/bash

PATH_CURR=$( cd "$(dirname "${BASH_SOURCE[0]}")" && pwd )

FILE_TARGET="/etc/systemd/system/kube-scheduler.service"
printf "\n\nContent of ${FILE_TARGET}\n\n"

cat <<EOF | sudo tee ${FILE_TARGET}
[Unit]
Description=Kubernetes Scheduler
Documentation=https://github.com/kubernetes/kubernetes

[Service]
User=root
ExecStart=/opt/kubernetes/server/bin/kube-scheduler \\
--logtostderr=true \\
--master=127.0.0.1:8080
Restart=on-failure
LimitNOFILE=65536

[Install]
WantedBy=multi-user.target
EOF
