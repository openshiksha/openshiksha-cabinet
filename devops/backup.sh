#!/usr/bin/env bash

# Usage: devops/backup.sh (from hwcentral-cabinet root dir)

# create the database dump which will be backed up by rackspace daily
mysqldump --single-transaction -uhwcreadonly -p$(cat /etc/hwcentral/db_read_password.txt) hwcentral_prod > ../db_bak/hwcentral_prod.sql

# push all changes in the cabinet git repository to trunk
git add .
git commit -a -m"backup - `date`"
git push origin master