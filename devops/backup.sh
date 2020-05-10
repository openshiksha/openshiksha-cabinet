#!/usr/bin/env bash

# Usage: devops/backup.sh (from root dir)

echo "Running backup script on $(date)" >> backup-tmp.log 2>&1

echo 'Dumping db state to backup file...' >> backup-tmp.log 2>&1

# create the database dump which will be backed up in a snapshot
mysqldump --single-transaction -u ${DB_BACKUP_USER} -p ${DB_BACKUP_PASSWORD} ${DB_NAME} 2>> backup-tmp.log 1> ../db_bak/${DB_NAME}.sql

echo 'db state dumped ->' >> backup-tmp.log 2>&1
ls -alt ../db_bak/ >> backup-tmp.log 2>&1

# push all changes in the cabinet git repository to trunk
git add . >> backup-tmp.log 2>&1
git commit -a -m"backup - `date`" >> backup-tmp.log 2>&1
git push origin master >> backup-tmp.log 2>&1

# send log email
echo 'Sending log email'
curl -s --user "api:${MAILGUN_APIKEY}" https://api.mailgun.net/v3/${MAILGUN_DOMAIN}/messages -F from="${MAILGUN_FROM}" -F to=exception@openshiksha.org -F subject='Nightly Backup' -F text="$(cat backup-tmp.log)"

# print log so that cron will append it to log file
cat backup-tmp.log

# cleanup
rm backup-tmp.log