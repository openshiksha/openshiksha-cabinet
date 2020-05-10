#!/usr/bin/env bash

# Usage: scripts/run.sh (from root dir)

COMPILED_NGINX_CONF=devops/nginx.compiled.conf

echo 'Stopping nginx...'
sudo nginx -s stop

echo 'compiling nginx conf'
cp devops/nginx.conf $COMPILED_NGINX_CONF

sed -i "s|__USER__|${USER}|g" $COMPILED_NGINX_CONF

sed -i "s|__CABINET_PATH__|${PWD}|g" $COMPILED_NGINX_CONF

sed -i "s|__ALLOWED_HOST__|127.0.0.1|g" $COMPILED_NGINX_CONF
sed -i "s|__SERVER_HOST__|localhost|g" $COMPILED_NGINX_CONF

sed -i "s|__DAV_ALLOWED_METHODS__|PUT DELETE|" $COMPILED_NGINX_CONF

echo 'Restarting nginx...'
sudo nginx
