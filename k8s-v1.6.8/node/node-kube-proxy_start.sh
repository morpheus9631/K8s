#!/bin/bash

printf "\n\n Reload daemon:\n\n"
systemctl daemon-reload

printf "\n\n Enable kubelet proxy:\n\n"
systemctl enable kube-proxy

printf "\n\n Start kubelet proxy:\n\n"
systemctl start kube-proxy

printf "\n\n Show status of kubelet proxy:\n\n"
systemctl status kube-proxy

echo "'


