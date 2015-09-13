#!/usr/bin/env bash

# Usage: devops/deploy.sh (from hwcentral-cabinet root dir)

sudo nginx -s stop
git pull origin master
#truncate logs
sudo truncate devops/nginx_access.log --size=0
sudo truncate devops/nginx_error.log --size=0
sudo nginx