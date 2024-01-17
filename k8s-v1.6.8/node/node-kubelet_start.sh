#!/bin/bash

printf "\n\n Reload daemon:\n\n"
systemctl daemon-reload

printf "\n\n Enable kubelet:\n\n"
systemctl enable kubelet

printf "\n\n Restart kubelet:\n\n"
systemctl restart kubelet

printf "\n\n Show status of kubelet:\n\n"
sudo service kubelet status

echo ""



