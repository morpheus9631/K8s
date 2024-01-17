#!/bin/bash

printf "\n\n-- Reload daemon\n\n"
systemctl daemon-reload

printf "\n\n-- Enable kube-scheduler\n\n"
systemctl enable kube-scheduler

printf "\n\n-- Restart kube-scheduler\n\n"
systemctl start kube-scheduler

printf "\n\n-- Show status of kube-controller-manager\n\n"scheduler
sudo service kube-scheduler status

echo ""

