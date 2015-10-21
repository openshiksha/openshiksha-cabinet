#!/usr/bin/env bash

# Usage: devops/configure-cron.sh (from hwcentral-cabinet root dir)

sudo cp devops/backup.cron /etc/cron.d/hwcentral_backup

# force reload of cron config by making service restart
sudo service cron restart