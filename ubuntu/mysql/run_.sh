#!/bin/bash
set -o nounset
cd $(dirname $0)
source context_

if [ -n "$DBNAME" ];then
    echo -e "\033[1;33mused db:\033[0m \033[1;32m${DBNAME}\033[0m"
fi

echo -en "\033[1;33mrun sql:\033[0m "
stty erase ^H
read SQL

if [ -z "$DBNAME" ];then
    mysql -h${HOSTNAME} -P${PORT} -u${USERNAME} -e"${SQL}"
else
    mysql -h${HOSTNAME} -P${PORT} -u${USERNAME} ${DBNAME} -e"${SQL}"
fi
