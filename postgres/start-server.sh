#!/bin/bash
set -e

POSTGRESQL_USER=${POSTGRESQL_USER:-"<your-db-username>"}
POSTGRESQL_PASS=${POSTGRESQL_PASS:-"<your-db-password>"}
POSTGRESQL_DB=${POSTGRESQL_DB:-"<your-db-name>"}
POSTGRESQL_TEMPLATE=${POSTGRESQL_TEMPLATE:-"TEMPLATE0"}

POSTGRESQL_BIN=/usr/lib/postgresql/9.3/bin/postgres
POSTGRESQL_CONFIG_FILE=/etc/postgresql/9.3/main/postgresql.conf
POSTGRESQL_DATA=/var/lib/postgresql/9.3/main

POSTGRESQL_SINGLE="sudo -u postgres $POSTGRESQL_BIN --single --config-file=$POSTGRESQL_CONFIG_FILE"

if [ ! -d $POSTGRESQL_DATA ]; then
    mkdir -p $POSTGRESQL_DATA
    chown -R postgres:postgres $POSTGRESQL_DATA
    sudo -u postgres /usr/lib/postgresql/9.3/bin/initdb -D $POSTGRESQL_DATA
    # enable for SSL
    # ln -s /etc/ssl/certs/ssl-cert-snakeoil.pem $POSTGRESQL_DATA/server.crt
    # ln -s /etc/ssl/private/ssl-cert-snakeoil.key $POSTGRESQL_DATA/server.key
fi

$POSTGRESQL_SINGLE <<< "CREATE USER \"$POSTGRESQL_USER\" WITH SUPERUSER;" > /dev/null
$POSTGRESQL_SINGLE <<< "ALTER USER \"$POSTGRESQL_USER\" WITH PASSWORD '$POSTGRESQL_PASS';" > /dev/null

# only create database if it doesn't exist yet
#$POSTGRESQL_SINGLE <<< "CREATE DATABASE \"$POSTGRESQL_DB\" OWNER \"$POSTGRESQL_USER\" TEMPLATE $POSTGRESQL_TEMPLATE;" > /dev/null

exec sudo -u postgres $POSTGRESQL_BIN -D $POSTGRESQL_DATA --config-file=$POSTGRESQL_CONFIG_FILE