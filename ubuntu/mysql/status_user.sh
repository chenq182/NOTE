#!/bin/bash
set -o nounset
cd $(dirname $0)
source context_

SQL="SELECT User,Host FROM mysql.user;"

mysql -h${HOSTNAME} -P${PORT} -u${USERNAME} -e"${SQL}"
