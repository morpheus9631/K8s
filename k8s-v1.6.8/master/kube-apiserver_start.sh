#!/bin/bash

printf "\n\n Reload daemon:\n\n"
systemctl daemon-reload

printf "\n\n Enable kube-apiserver:\n\n"
systemctl enable kube-apiserver

printf "\n\n Restart kube-apiserver:\n\n"
systemctl start kube-apiserver

printf "\n\n Show kube-apiserver status:\n\n"
systemctl status kube-apiserver

echo ""



