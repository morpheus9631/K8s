#!/bin/bash

if [ -z $1 ]; then
  echo "Username not found ..."
  exit 1;
fi
USER=$1

sudo usermod -aG docker ${USER}

