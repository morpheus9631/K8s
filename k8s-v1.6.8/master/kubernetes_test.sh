#!/bin/bash

clear
kubectl version

printf "\n"
kubectl get nodes -o wide
printf "\n"

