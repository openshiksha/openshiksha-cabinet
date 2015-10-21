#!/usr/bin/env bash

# Usage: scripts/docker-init.sh (from hwcentral-cabinet root dir)

echo 'updating the nginx conf to use current username'
sed -i s/oasis/$USER/g devops/nginx.conf

echo 'updating the cabinet endpoints for docker setup'
sed -i "s/allow 10.130.67.205/allow $DOCKER_HOST_IP/" devops/nginx.conf
sed -i "s/server_name 10.130.97.154/server_name localhost/" devops/nginx.conf

echo 'enabling delete dav method for dev testing'
sed -i "s/dav_methods PUT/dav_methods PUT DELETE/" devops/nginx.conf

echo 'Starting nginx...'
sudo nginx -g "daemon off;"