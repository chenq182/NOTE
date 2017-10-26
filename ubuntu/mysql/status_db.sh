#!/bin/bash
set -o nounset
cd $(dirname $0)
source context_

SQL="SHOW DATABASES;"

mysql -h${HOSTNAME} -P${PORT} -u${USERNAME} -e"${SQL}"
