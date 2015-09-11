#!/usr/bin/env bash

# Usage: devops/deploy.sh (from hwcentral-cabinet root dir)

nginx -s stop
git pull origin master
sudo find ./ -type d -exec chmod 777 {} +
sudo find ./ -type f -exec chmod 666 {} +
nginx