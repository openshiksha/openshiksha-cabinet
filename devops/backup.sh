#!/usr/bin/env bash

# Usage: devops/backup.sh (from hwcentral-cabinet root dir)

echo "Running backup script on $(date)" >> backup-log.tmp 2>&1

echo 'Dumping db state to backup file...' >> backup-log.tmp 2>&1

# create the database dump which will be backed up by rackspace daily
mysqldump --single-transaction -uhwcreadonly -p$(cat /etc/hwcentral/db_read_password.txt) hwcentral_prod 2>> backup-log.tmp 1> ../db_bak/hwcentral_prod.sql

echo 'db state dumped ->' >> backup-log.tmp 2>&1
ls -alt ../db_bak/ >> backup-log.tmp 2>&1

# push all changes in the cabinet git repository to trunk
git add . >> backup-log.tmp 2>&1
git commit -a -m"backup - `date`" >> backup-log.tmp 2>&1
git push origin master >> backup-log.tmp 2>&1

# send log email
echo 'Sending log email'
curl -s --user "api:$(cat /etc/hwcentral/mailgun_apikey.txt)" https://api.mailgun.net/v3/hwcentral.in/messages -F from='DB Server <postmaster@hwcentral.in>' -F to=exception@hwcentral.in -F subject='Nightly Backup' -F text="$(cat backup-log.tmp)"

# print log so that cron will append it to log file
cat backup-log.tmp

# cleanup
rm backup-log.tmp