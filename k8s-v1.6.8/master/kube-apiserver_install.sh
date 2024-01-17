# Install api server on k8s-master1 & 2

PATH_CURR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

PATH_DOWNLOAD=${PATH_CURR}"/../downloads/"
mkdir -p ${PATH_DOWNLOAD}
cd ${PATH_DOWNLOAD}

FILE_DOWNLOAD="kubernetes-server-linux-amd64.tar.gz"
wget -nc "https://dl.k8s.io/v1.6.8/"${FILE_DOWNLOAD}

PATH_INSTALL="/opt/"
sudo tar zxf ${FILE_DOWNLOAD} -C ${PATH_INSTALL}

PATH_K8S=${PATH_INSTALL}"kubernetes/"
sudo chmod -R 755 "${PATH_K8S}"

printf "\n\n Directory of ${PATH_K8S}:\n\n"
ls -l --color=auto "${PATH_K8S}"

PATH_KUBECTL=${PATH_K8S}"server/bin/kubectl"
PATH_USR_LOCAL_BIN="/usr/local/bin/"
sudo cp ${PATH_KUBECTL} ${PATH_USR_LOCAL_BIN}

printf "\n\n Directory of ${PATH_USR_LOCAL_BIN}:\n\n"
ls -l --color=auto ${PATH_USR_LOCAL_BIN}

echo ""
