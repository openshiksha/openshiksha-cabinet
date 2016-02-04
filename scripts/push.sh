#!/usr/bin/env bash

# Usage: scripts/push.sh (from hwcentral-cabinet root dir)

echo 'Reverting changes to nginx conf...'
git checkout devops/nginx.conf

echo "Enter commit message: "
read msg

echo 'Commiting changes...'
git commit -a -m"$msg"

echo 'Pushing to master...'
git push origin master
