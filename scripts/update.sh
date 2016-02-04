#!/usr/bin/env bash

# Usage: scripts/update.sh (from hwcentral-cabinet root dir)

echo 'Stopping nginx...'
sudo nginx -s stop

echo 'This will delete your local changes (INCLUDING SUBMISSIONS) that your cabinet contains!'
echo 'Press Ctrl+C to quit. Press Enter to continue'
read -p "$*"

git reset --hard HEAD
git clean -df

git pull origin master

echo 'updating the nginx conf to use current username'
sed -i s/oasis/$USER/g devops/nginx.conf

echo 'updating the cabinet endpoints for localhost setup'
sed -i "s/allow 10.176.5.116/allow 127.0.0.1/" devops/nginx.conf
sed -i "s/server_name 10.176.7.252/server_name localhost/" devops/nginx.conf

echo 'enabling delete dav method for dev testing'
sed -i "s/dav_methods PUT/dav_methods PUT DELETE/" devops/nginx.conf

echo 'switching the current repo to be the local cabinet (if it isnt already)'
if [ "$HOME/hwcentral-cabinet" != "${PWD}" ]; then
    mv $HOME/hwcentral-cabinet $HOME/hwcentral-cabinet-qa
    mv ${PWD} $HOME/hwcentral-cabinet
fi

echo 'Restarting nginx...'
sudo nginx
