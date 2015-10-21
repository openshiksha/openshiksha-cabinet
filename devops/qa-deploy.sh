#!/usr/bin/env bash

# Usage: devops/qa-deploy.sh (from hwcentral-cabinet root dir)

# reset local nginx conf changes
git checkout devops/nginx.conf

# stash the remaining changes (should only be submissions)
git add submissions
git stash

devops/deploy.sh

# reapply stashed changes
git stash apply

# commit and push the changes (new submissions) - as a way of doing backup <TODO: explore possibility of using seperate branch for backup> 
git add .
git commit -a -m"QA submissions backup: $(date)"
git push origin master

# reapply the nginx conf changes
echo 'updating the cabinet endpoints for qa setup'
sed -i "s/allow 10.176.5.116/allow 10.130.67.205/" devops/nginx.conf
sed -i "s/server_name 10.176.7.252/server_name 10.130.97.154/" devops/nginx.conf

# reload nginx with qa conf file
sudo nginx -s reload