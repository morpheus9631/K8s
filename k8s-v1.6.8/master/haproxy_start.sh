#!/bin/bash

docker run -d --name proxy \
-v /opt/haproxy.cfg:/usr/local/etc/haproxy/haproxy.cfg:ro \
--net=host \
--restart=always haproxy
