#!/bin/bash

PATH_CURR=$( cd "$(dirname "${BASH_SOURCE[0]}" )" && pwd )

#
# Build update_docker.sh
#

# Change docker subnet
FILE_TARGET="/opt/flannel/update_docker.sh"
printf "\n\n-- Content of ${FILE_TARGET} \n\n"

cat <<EOF | sudo tee ${FILE_TARGET}
#!/bin/bash

#
# Change docker subnet
#
source /run/flannel/subnet.env
sed -i "s|ExecStart=.*|ExecStart=\/usr\/bin\/dockerd -H tcp:\/\/127.0.0.1:4243 -H unix:\/\/\/var\/run\/docker.sock \\
--bip=\${FLANNEL_SUBNET} \\
--mtu=\${FLANNEL_MTU}|g" /lib/systemd/system/docker.service

# Remove docker0
rc=0
ip link show docker0 >/dev/null 2>&1 || rc="$?"
if [[ "\${rc}" -eq "0" ]]; then
  ip link set dev docker0 down
  ip link delete docker0
fi

systemctl daemon-reload

# Restart docker if docker already exist
DOCKERNUM=$(ps -ef | grep "dockerd" | grep -v "grep" | wc -l)
if [ "\${DOCKERNUM}" -eq "1" ]; then
  systemctl restart docker
fi
EOF

sudo chmod +x ${FILE_TARGET}
sudo chown user:user ${FILE_TARGET}
echo ""
ls -l --color=auto "/opt/flannel/"
echo ""

#
# Set Flannel Network
#
/opt/etcd/bin/etcdctl set /coreos.com/network/config '{"Network":"172.17.0.0/16", "Backend": {"Type": "vxlan"}}'

