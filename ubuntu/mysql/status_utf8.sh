#!/bin/bash

HOSTNAME="127.0.0.1"
PORT="3306"
USERNAME="root"
PASSWORD="123456"

SQL="SHOW VARIABLES LIKE '%character%';"

mysql -h${HOSTNAME} -P${PORT} -u${USERNAME} -p${PASSWORD} -e"${SQL}"
