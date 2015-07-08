#!/usr/bin/env bash

# Usage: scripts/deploy.sh (from hwcentral-cabinet root dir)

git pull origin master
sudo find ./ -type d -exec chmod 777 {} +
sudo find ./ -type f -exec chmod 666 {} +
