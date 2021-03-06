#!/bin/bash
set -o nounset
cd $(dirname $0)
source context_

if [ -n "$DBNAME" ];then
    echo -e "\033[1;33musing db:\033[0m \033[1;32m${DBNAME}\033[0m"
fi

echo -en "\033[1;33mdel name:\033[0m "
stty erase ^H
read NAME
echo -en "\033[1;33mdel host:\033[0m "
read HOST
SQL="DROP USER ${NAME}@'${HOST}';"

mysql -h${HOSTNAME} -P${PORT} -u${USERNAME} -e"${SQL}"
