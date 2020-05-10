#!/usr/bin/env bash

# Usage: scripts/docker-init.sh (from root dir)

NGINX_CONF_FILE=devops/nginx.conf

echo 'compiling nginx conf'
sed -i "s|__USER__|${USER}|g" $NGINX_CONF_FILE

sed -i "s|__CABINET_PATH__|${PWD}|g" $NGINX_CONF_FILE
sed -i "s|__ALLOWED_HOST__|${DOCKER_HOST_IP}/|g" $NGINX_CONF_FILE
sed -i "s|__SERVER_HOST__|localhost|g" $NGINX_CONF_FILE


echo 'enabling delete dav method for dev testing'
sed -i "s|__DAV_ALLOWED_METHODS__|PUT DELETE|" $NGINX_CONF_FILE

echo 'Starting nginx...'
sudo nginx -g "daemon off;"