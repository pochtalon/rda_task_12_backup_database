#! /bin/bash

# Getting values from env variables
USER="${DB_USER}"
PASSWORD="${DB_PASSWORD}"

# Checking variables
if [ -z "$USER" ]; then
    echo "Environment variable DB_USER is not set."
    exit 1
fi

if [ -z "$PASSWORD" ]; then
    echo "Environment variable DB_PASSWORD is not set."
    exit 1
fi

# Making full backup for ShopDB data base
mysqldump -u "$USER" -p "$PASSWORD" --databases ShopDB --result-file=full_backup.sql

# Restoring new db from backup
mysql -u "$USER" -p "$PASSWORD" ShopDBReserve < full_backup.sql

# Making data backup for ShopDB data base
mysqldump -u "$USER" -p "$PASSWORD" --no-create-info --skip-add-drop-table --databases ShopDB --result-file=data_backup.sql

# Moving data from the production database
mysql -u "$USER" -p "$PASSWORD" ShopDBDevelopment < data_backup.sql
