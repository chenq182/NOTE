#!/bin/bash
set -o nounset
cd $(dirname $0)
source context_

if [ -n "$DBNAME" ];then
    echo -e "\033[1;33mused db:\033[0m \033[1;32m${DBNAME}\033[0m"
fi

echo -en "\033[1;33mdb name:\033[0m "
stty erase ^H
read DB
SQL="CREATE DATABASE IF NOT EXISTS ${DB};"

mysql -h${HOSTNAME} -P${PORT} -u${USERNAME} -e"${SQL}"
