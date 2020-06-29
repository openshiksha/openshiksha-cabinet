#!/usr/bin/env bash

# Usage: devops/compile-nginx.sh  <allowed-host> <server-name> (from project root dir)

COMPILED_NGINX_CONF=devops/nginx.compiled.conf
ALLOWED_HOST=${1-127.0.0.1}
SERVER_NAME=${2-localhost}

echo 'compiling nginx conf'
cp devops/nginx.conf $COMPILED_NGINX_CONF

sed -i "s|__USER__|${USER}|g" $COMPILED_NGINX_CONF

sed -i "s|__CABINET_PATH__|${PWD}|g" $COMPILED_NGINX_CONF

sed -i "s|__ALLOWED_HOST__|${ALLOWED_HOST}|g" $COMPILED_NGINX_CONF
sed -i "s|__SERVER_NAME__|${SERVER_NAME}|g" $COMPILED_NGINX_CONF