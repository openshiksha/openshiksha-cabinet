#!/usr/bin/env bash

# Usage: devops/backup.sh (from hwcentral-cabinet root dir)

echo "Running backup script on $(date)" >> backup-tmp.log 2>&1

echo 'Dumping db state to backup file...' >> backup-tmp.log 2>&1

# create the database dump which will be backed up by rackspace daily
mysqldump --single-transaction -uhwcreadonly -p$(cat /etc/hwcentral/db_read_password.txt) hwcentral_prod 2>> backup-tmp.log 1> ../db_bak/hwcentral_prod.sql

echo 'db state dumped ->' >> backup-tmp.log 2>&1
ls -alt ../db_bak/ >> backup-tmp.log 2>&1

# push all changes in the cabinet git repository to trunk
git add . >> backup-tmp.log 2>&1
git commit -a -m"backup - `date`" >> backup-tmp.log 2>&1
git push origin master >> backup-tmp.log 2>&1

# send log email
echo 'Sending log email'
curl -s --user "api:$(cat /etc/hwcentral/mailgun_apikey.txt)" https://api.mailgun.net/v3/hwcentral.in/messages -F from='DB Server <postmaster@hwcentral.in>' -F to=exception@hwcentral.in -F subject='Nightly Backup' -F text="$(cat backup-tmp.log)"

# print log so that cron will append it to log file
cat backup-tmp.log

# cleanup
rm backup-tmp.log