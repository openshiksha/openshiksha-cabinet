#!/usr/bin/env bash

# Usage: scripts/run.sh (from root dir)

COMPILED_NGINX_CONF=devops/nginx.compiled.conf

echo 'Stopping nginx...'
sudo nginx -s stop

devops/compile-nginx.sh

echo 'Restarting nginx...'
sudo nginx
