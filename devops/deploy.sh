#!/usr/bin/env bash

# Usage: devops/deploy.sh (from hwcentral-cabinet root dir)

nginx -s stop
git pull origin master
nginx