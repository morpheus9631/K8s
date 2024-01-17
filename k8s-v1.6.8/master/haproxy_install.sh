#!/bin/bash

PATH_CURR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
PATH_WORK=${PATH_CURR}"/../downloads/"

if [ ! -d ${PATH_WORK} ]; then
  mkdir -p ${PATH_WORK}
fi

docker pull haproxy
docker images
docker save -o ${PATH_WORK}"haproxy.tar" haproxy

printf "\n\n Directory of ${PATH_WORK}:\n\n"
ls -l --color=auto ${PATH_WORK}
