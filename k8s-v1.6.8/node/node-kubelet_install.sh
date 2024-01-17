# Install kubelet on nodes

PATH_CURR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

PATH_WORK=${PATH_CURR}"/../downloads/"
if [ ! -d ${PATH_WORK} ]; then
  mkdir -p ${PATH_WORK}
fi

cd ${PATH_WORK}
FILE_WGET="kubernetes-server-linux-amd64.tar.gz"
wget -nc "https://dl.k8s.io/v1.6.8/"${FILE_WGET}

PATH_INSTALL="/opt/"
sudo tar zxf ${FILE_WGET} -C ${PATH_INSTALL}

PATH_K8S=${PATH_INSTALL}"kubernetes/"
sudo chmod -R 755 "${PATH_K8S}"

printf "\n\n Directory of ${PATH_K8S}:\n\n"
ls -l --color=auto "${PATH_K8S}"




