#! /bin/bash

# Getting values from env variables
USER="${DB_USER}"
PASSWORD="${DB_PASSWORD}"

# Making full backup for ShopDB data base
mysqldump -u "$USER" -p "$PASSWORD" --databases ShopDB --result-file=full_backup.sql

# Restoring new db from backup
mysql -u "$USER" -p "$PASSWORD" ShopDBReserve < full_backup.sql

# Making data backup for ShopDB data base
mysqldump -u "$USER" -p "$PASSWORD" --no-create-info --skip-add-drop-table --databases ShopDB --result-file=data_backup.sql

# Moving data from the production database
mysql -u "$USER" -p "$PASSWORD" ShopDBDevelopment < data_backup.sql