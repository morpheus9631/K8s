#!/bin/bash

printf "\n\n-- Reload daemon\n\n"
systemctl daemon-reload

printf "\n\n-- Enable kube-controller-manager\n\n"
systemctl enable kube-controller-manager

printf "\n\n-- Restart kube-controller-manager\n\n"
systemctl restart kube-controller-manager

printf "\n\n-- Show status of kube-controller-manager\n\n"
systemctl status kube-controller-manager

echo ""


