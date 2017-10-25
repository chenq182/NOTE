#!/bin/bash

set -o nounset
# git clone https://github.com/chenq182/NOTE

git add .
git commit -m "$(date "+%Y-%m-%d %H:%M:%S")"
git push origin master

# vim: set tabstop=4 shiftwidth=4:
