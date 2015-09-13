#!/usr/bin/env bash

# Usage: devops/deploy.sh (from hwcentral-cabinet root dir)

sudo nginx -s stop
git pull origin master
#truncate logs
truncate devops/*.log --size=0
sudo nginx