#!/bin/bash

printf "\n\n-- Reload daemon:\n\n"
systemctl daemon-reload

printf "\n\n-- Enable ETCD:\n\n"
systemctl enable etcd

printf "\n\n-- Start ETCD:\n\n"
systemctl start etcd

printf "\n\n-- Show ETCD status:\n\n"
sudo service etcd status




