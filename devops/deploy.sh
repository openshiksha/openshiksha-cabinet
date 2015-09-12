#!/usr/bin/env bash

# Usage: devops/deploy.sh (from hwcentral-cabinet root dir)

sudo nginx -s stop
git pull origin master
sudo nginx