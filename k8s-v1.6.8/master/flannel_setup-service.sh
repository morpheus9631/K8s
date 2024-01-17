#!/bin/bash

PATH_CURR=$( cd "$(dirname "${BASH_SOURCE[0]}" )" && pwd )

#
# Get parameters from k8s-config.json
#
IP_MASTERS=( $(jq -r '.masters[].ip' k8s-config.json) )
#printf '%s\n' "${IP_MASTERS[@]}"

VALUE=""
for ip in "${IP_MASTERS[@]}"
do
  if [ ! ${#VALUE} == 0 ]; then VALUE=${VALUE}","; fi
  VALUE=${VALUE}"http://"${ip}":2379"
done
IP_ETCD_SERVERS=${VALUE}

NAME_IFAC=( $(jq -r '.interfaces[] | select(.id=="inet") | .name' k8s-config.json) )

#
# Build flanneld.service
#
cat <<EOF | sudo tee /etc/systemd/system/flanneld.service
[Unit]
Description=Flanneld
Documentation=https://github.com/coreos/flannel
After=network.target etcd.service
Before=docker.service

[Service]
User=root
ExecStart=/opt/flannel/flanneld \\
--etcd-endpoints=${IP_ETCD_SERVERS} \\
--iface=${NAME_IFAC} \\
--ip-masq
ExecStartPost=/bin/bash /opt/flannel/update_docker.sh
Restart=on-failure
Type=notify
LimitNOFILE=65536

[Install]
WantedBy=multi-user.target
EOF

# Create flanneld link in multi-user
sudo ln -s /etc/systemd/system/flanneld.service /etc/systemd/system/multi-user.target.wants/flanneld.service

# Show link status
printf "\n\n Check flannel link:\n\n"
ls -l --color=auto /etc/systemd/system/multi-user.target.wants/flanneld*
echo ""

