#!/bin/bash

HOSTNAME="127.0.0.1"
PORT="3306"
USERNAME="root"
PASSWORD="123456"

SQL="SELECT User,Host FROM mysql.user;"

mysql -h${HOSTNAME} -P${PORT} -u${USERNAME} -p${PASSWORD} -e"${SQL}"
