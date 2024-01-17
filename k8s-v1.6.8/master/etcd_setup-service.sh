#!/bin/bash

PATH_CURR=$( cd "$(dirname "${BASH_SOURCE[0]}" )" && pwd )

#
# Set etcd service
#
FILE_SERVICE="/etc/systemd/system/etcd.service"
printf "\n\n-- Set etcd service config at ${FILE_SERVICE}:\n\n"

cat <<EOF | sudo tee ${FILE_SERVICE}
[Unit]
Description=Etcd Server
Documentation=https://github.com/coreos/etcd
After=network.target

[Service]
User=root
Type=notify
EnvironmentFile=-/opt/etcd/config/etcd.conf
ExecStart=/opt/etcd/bin/etcd
Restart=on-failure
RestartSec=10s
LimitNOFILE=40000

[Install]
WantedBy=multi-user.target
EOF
echo ""







