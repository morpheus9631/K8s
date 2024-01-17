# Install etcd on k8s-master1 & 2

PATH_CURR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
PATH_WGET=${PATH_CURR}"/../downloads/"

FILE_TARGET="etcd-v3.2.4-linux-amd64.tar.gz"
mkdir -p ${PATH_WGET}
cd ${PATH_WGET}
wget -nc "https://github.com/coreos/etcd/releases/download/v3.2.4/"${FILE_TARGET}
tar zxf ${FILE_TARGET}
ls -l --color=auto ${PATH_WGET}"etcd-v3.2.4-linux-amd64"

PATH_TARGET="/opt/etcd/bin/"
sudo mkdir -p ${PATH_TARGET}
sudo chown -R user:user /opt/etcd
mv ${PATH_WGET}etcd-v3.2.4-linux-amd64/etcd* ${PATH_TARGET}
ls -l --color=auto ${PATH_TARGET}

