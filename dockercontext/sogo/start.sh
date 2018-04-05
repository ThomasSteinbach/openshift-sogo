#!/bin/bash

set -e

MYSQL_HOST="${SOGO_MYSQL_HOST:-mysql}"
MYSQL_PORT="${SOGO_MYSQL_PORT:-3306}"
MYSQL_USER="${SOGO_MYSQL_USER:-sogo}"
MYSQL_PASSWORD="${SOGO_MYSQL_PASSWORD:-sogo}"
MYSQL_DATABASE="${SOGO_MYSQL_DATABASE:-sogo}"
MEMCACHED_HOST="${MEMCACHED_HOST:-memcached}"

# configure database settings in maintainance scripts
sed -i "s#MYSQL_HOST#${MYSQL_HOST}#g" /usr/local/bin/addsogouser /usr/local/bin/delsogouser
sed -i "s#MYSQL_PORT#${MYSQL_PORT}#g" /usr/local/bin/addsogouser /usr/local/bin/delsogouser
sed -i "s#MYSQL_USER#${MYSQL_USER}#g" /usr/local/bin/addsogouser /usr/local/bin/delsogouser
sed -i "s#MYSQL_PASSWORD#${MYSQL_PASSWORD}#g" /usr/local/bin/addsogouser /usr/local/bin/delsogouser
sed -i "s#MYSQL_DATABASE#${MYSQL_DATABASE}#g" /usr/local/bin/addsogouser /usr/local/bin/delsogouser

# create default conf in mountpoint
if [ ! -f /etc/sogo/sogo.conf ]; then
  cp /sogo-orig.conf /etc/sogo/sogo.conf
fi

# check permissions of mounted files
chown -R root:sogo /etc/sogo
chmod 750 /etc/sogo
chmod 640 /etc/sogo/sogo.conf

# database settings
mysql -h${MYSQL_HOST} -u${MYSQL_USER} -p${MYSQL_PASSWORD} -D${MYSQL_DATABASE} -e "CREATE TABLE IF NOT EXISTS sogo_users (c_uid VARCHAR(10) PRIMARY KEY, c_name VARCHAR(10), c_password VARCHAR(32), c_cn VARCHAR(128), mail VARCHAR(128));"

# sogo server settings
sudo -u sogo defaults write sogod SOGoLanguage 'German'
sudo -u sogo defaults write sogod SOGoTimeZone 'Europe/Berlin'
sudo -u sogo defaults write sogod SOGoMemcachedHost "$MEMCACHED_HOST"
sudo -u sogo defaults write sogod SOGoUserSources "({canAuthenticate = YES; displayName = \"SOGo Users\"; id = users; isAddressBook = YES; type = sql; userPasswordAlgorithm = md5; viewURL =\"mysql://${MYSQL_USER}:${MYSQL_PASSWORD}@${MYSQL_HOST}:${MYSQL_PORT}/${MYSQL_DATABASE}/sogo_users\";})"
sudo -u sogo defaults write sogod SOGoProfileURL "mysql://${MYSQL_USER}:${MYSQL_PASSWORD}@${MYSQL_HOST}:${MYSQL_PORT}/${MYSQL_DATABASE}/sogo_user_profile"
sudo -u sogo defaults write sogod OCSFolderInfoURL "mysql://${MYSQL_USER}:${MYSQL_PASSWORD}@${MYSQL_HOST}:${MYSQL_PORT}/${MYSQL_DATABASE}/sogo_folder_info"
sudo -u sogo defaults write sogod OCSSessionsFolderURL "mysql://${MYSQL_USER}:${MYSQL_PASSWORD}@${MYSQL_HOST}:${MYSQL_PORT}/${MYSQL_DATABASE}/sogo_sessions_folder"
sudo -u sogo defaults write sogod WOPort '0.0.0.0:20000'

/etc/init.d/sogo start
tail -f /var/log/sogo/sogo.log
