#!/bin/bash

SERVER_PROTOCOL=${SERVER_PROTOCOL:-http}
SERVER_NAME=${SERVER_NAME:-localhost}
SERVER_PORT=${SERVER_PORT:-80}

sed -i "s/SERVER_PROTOCOL/${SERVER_PROTOCOL}/g" /usr/local/apache2/conf/httpd.conf
sed -i "s/SERVER_NAME/${SERVER_NAME}/g" /usr/local/apache2/conf/httpd.conf
sed -i "s/SERVER_PORT/${SERVER_PORT}/g" /usr/local/apache2/conf/httpd.conf

exec httpd-foreground
