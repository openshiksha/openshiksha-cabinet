#!/usr/bin/env bash

# Usage: devops/compile-nginx.sh (from project root dir)

COMPILED_NGINX_CONF=devops/nginx.compiled.conf

echo 'compiling nginx conf'
cp devops/nginx.conf $COMPILED_NGINX_CONF

sed -i "s|__USER__|${USER}|g" $COMPILED_NGINX_CONF

sed -i "s|__CABINET_PATH__|${PWD}|g" $COMPILED_NGINX_CONF