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
IP_HOST=$( ip a s ${NAME_IFAC} | awk '/inet.*brd/ {print $2}' | awk -F'/' '{print $1}' )

IP_RANGE="192.168.100.0/24"
#echo ${IP_HOST}
#echo ${IP_RANGE}

#
# Start Create service file
#
FILE_SERVICE="/etc/systemd/system/kube-apiserver.service"
printf "\n\n-- Content of ${FILE_SERVICE}:\n\n"

cat <<EOF | sudo tee ${FILE_SERVICE}
[Unit]
Description=Kubernetes API Server
Documentation=https://github.com/kubernetes/kubernetes
After=network.target

[Service]
User=root
ExecStart=/opt/kubernetes/server/bin/kube-apiserver \\
--insecure-bind-address=0.0.0.0 \\
--insecure-port=8080 \\
--etcd-servers=${IP_ETCD_SERVERS} \\
--logtostderr=true \\
--allow-privileged=false \\
--service-cluster-ip-range=${IP_RANGE} \\
--admission-control=NamespaceLifecycle,LimitRanger,ServiceAccount,SecurityContextDeny,ResourceQuota \\
--service-node-port-range=30000-32767 \\
--advertise-address=${IP_HOST} \\
--client-ca-file=/srv/kubernetes/key/ca.crt \\
--tls-cert-file=/srv/kubernetes/key/server.crt \\
--tls-private-key-file=/srv/kubernetes/key/server.key
Restart=on-failure
Type=notify
LimitNOFILE=65536

[Install]
WantedBy=multi-user.target
EOF
