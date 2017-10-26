#!/bin/bash
set -o nounset
cd $(dirname $0)
source context_

if [ -n "$DBNAME" ];then
    echo -e "\033[1;33musing db:\033[0m \033[1;32m${DBNAME}\033[0m"
fi

echo -en "\033[1;33madd name:\033[0m "
stty erase ^H
read NAME
echo -en "\033[1;33madd host:\033[0m "
read HOST
echo -en "\033[1;33mpassword:\033[0m "
read PASS
SQL="GRANT ALL PRIVILEGES ON *.* TO ${NAME}@'${HOST}' IDENTIFIED BY '${PASS}';FLUSH PRIVILEGES;"

mysql -h${HOSTNAME} -P${PORT} -u${USERNAME} -e"${SQL}"
