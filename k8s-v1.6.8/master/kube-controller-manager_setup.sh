#!/bin/bash

PATH_CURR=$( cd "$(dirname "${BASH_SOURCE[0]}" )" && pwd )

FILE_TARGET="/etc/systemd/system/kube-controller-manager.service"
printf "\n\nContent of ${FILE_TARGET}\n\n"

cat <<EOF | sudo tee ${FILE_TARGET}
[Unit]
Description=Kubernetes Controller Manager
Documentation=https://github.com/kubernetes/kubernetes

[Service]
User=root
ExecStart=/opt/kubernetes/server/bin/kube-controller-manager \\
--master=127.0.0.1:8080 \\
--root-ca-file=/srv/kubernetes/key/ca.crt \\
--service-account-private-key-file=/srv/kubernetes/key/server.key \\
--logtostderr=true
Restart=on-failure
LimitNOFILE=65536

[Install]
WantedBy=multi-user.target
EOF
