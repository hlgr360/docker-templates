#!/bin/bash 

# add db server and port to apache env
echo "export DB_PORT_5432_TCP_ADDR=`echo $DB_PORT_5432_TCP_ADDR`" >> /etc/apache2/envvars
echo "export DB_PORT_5432_TCP_PORT=`echo $DB_PORT_5432_TCP_PORT`" >> /etc/apache2/envvars

# start apache
/usr/sbin/apache2 -D FOREGROUND