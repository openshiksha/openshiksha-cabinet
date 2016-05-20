#!/usr/bin/env bash

# Usage: hwcentral-cabinet/devops/backup.sh (from home dir)

cd hwcentral-cabinet

echo "Running backup script on $(date)" >> backup-tmp.log 2>&1

echo 'Dumping db state to backup file...' >> backup-tmp.log 2>&1

# create the database dump which will be backed up in a snapshot
mysqldump --single-transaction -u$(cat /etc/hwcentral/db_backup_user.txt) -p$(cat /etc/hwcentral/db_backup_password.txt) $(cat /etc/hwcentral/db_name.txt) 2>> backup-tmp.log 1> ../db_bak/$(cat /etc/hwcentral/db_name.txt).sql

echo 'db state dumped ->' >> backup-tmp.log 2>&1
ls -alt ../db_bak/ >> backup-tmp.log 2>&1

# push all changes in the cabinet git repository to trunk
git add . >> backup-tmp.log 2>&1
git commit -a -m"backup - `date`" >> backup-tmp.log 2>&1
git push origin master >> backup-tmp.log 2>&1

# send log email
echo 'Sending log email'
curl -s --user "api:$(cat /etc/hwcentral/mailgun_apikey.txt)" https://api.mailgun.net/v3/$(cat /etc/hwcentral/mailgun_domain.txt)/messages -F from="$(cat /etc/hwcentral/mailgun_from.txt)" -F to=exception@openshiksha.org -F subject='Nightly Backup' -F text="$(cat backup-tmp.log)"

# print log so that cron will append it to log file
cat backup-tmp.log

# cleanup
rm backup-tmp.log