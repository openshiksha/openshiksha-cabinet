#!/usr/bin/env bash

# Usage: scripts/update.sh (from hwcentral-cabinet root dir)

echo 'Stopping nginx...'
sudo nginx -s stop

echo 'This will delete your local changes (INCLUDING SUBMISSIONS) that your cabinet contains. Press Ctrl+C to quit'
read -p "$*"

git reset --hard HEAD
git clean -df

git pull origin master

echo 'updating the nginx conf to use current username'
sed s/oasis/sidhant/g devops/nginx.conf
echo 'Restarting nginx...'
sudo nginx