#! /bin/bash

mysqldump -u "$DB_USER" -p"$DB_PASSWORD" ShopDB --result-file=full-backup.sql --no-create-db
mysql -u "$DB_USER" -p"$DB_PASSWORD" ShopDBReserve < full-backup.sql

mysqldump -u "$DB_USER" -p"$DB_PASSWORD" ShopDB --result-file=data-backup.sql --no-create-info
mysql -u "$DB_USER" -p"$DB_PASSWORD" ShopDBDevelopment < data-backup.sql

