#!/bin/bash

find /etc -name 000-default.conf
cd /etc/apache2/sites-enabled
ln -s ../sites-available/001-default.conf

ln -s /etc/apache2 conf
ln -s /var/log/apache2 log

/etc/init.d/apache2 start
/etc/init.d/apache2 stop

