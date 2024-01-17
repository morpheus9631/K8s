#!/bin/bash

PATH_CURR=$( cd "$(dirname "${BASH_SOURCE[0]}" )" && pwd )

ID_MASTERS=( $(jq -r '.masters[].id' k8s-config.json) )
#printf '%s\n' "${ID_MASTERS[@]}"

#IP_MASTERS=( $(jq -r '.masters[].ip' k8s-config.json) )
#printf '%s\n' "${IP_MASTERS[@]}"

NAME_IFAC=( $(jq -r '.interfaces[] | select(.id=="inet") | .name' k8s-config.json) )
#echo "Name of interface: "${NAME_IFAC}

IP_HOST=$( ip a s ${NAME_IFAC} | awk '/inet.*brd/ {print $2}' | awk -F'/' '{print $1}' )
#echo "IP address of host: "${IP_HOST}

# Create etcd intial cluster value
VALUE=""
for id in "${ID_MASTERS[@]}"
do
  ip=( $(jq -r --arg ID "$id" '.masters[] | select(.id==$ID) | .ip' k8s-config.json) )
  #echo ${id}": "${ip}
  if [ ! ${#VALUE} == 0 ]; then VALUE=${VALUE}","; fi
  VALUE=${VALUE}${id}"=http://"${ip}":2380"
done
VAL_INIT_CLUSTER=${VALUE}
#echo ${VAL_INIT_CLUSTER}

#
# Create etcd config
#
PATH_CONFIG="/opt/etcd/config/"
FILE_CONFIG="etcd.conf"

if [ ! -d ${PATH_CONFIG} ]; then mkdir -p ${PATH_CONFIG}; fi
printf "\n\n-- Set etcd config at ${PATH_CONFIG}${FILE_CONFIG}:\n\n"

cat <<EOF | sudo tee ${PATH_CONFIG}${FILE_CONFIG}
ETCD_DATA_DIR=/var/lib/etcd
ETCD_NAME=$(hostname -s)
ETCD_LISTEN_PEER_URLS=http://0.0.0.0:2380
ETCD_LISTEN_CLIENT_URLS=http://0.0.0.0:2379
ETCD_INITIAL_CLUSTER_STATE=new
ETCD_INITIAL_CLUSTER=${VAL_INIT_CLUSTER}
ETCD_INITIAL_ADVERTISE_PEER_URLS=http://${IP_HOST}:2380
ETCD_ADVERTISE_CLIENT_URLS=http://${IP_HOST}:2379
ETCD_HEARTBEAT_INTERVAL=6000
ETCD_ELECTION_TIMEOUT=30000
GOMAXPROCS=$(nproc)
EOF

echo ""






