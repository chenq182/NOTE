#!/bin/bash
set -o nounset
cd $(dirname $0)
source context_

SQL="SHOW VARIABLES LIKE '%character%';"

mysql -h${HOSTNAME} -P${PORT} -u${USERNAME} -e"${SQL}"
