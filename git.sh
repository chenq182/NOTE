#!/bin/bash

set -o nounset
# git clone https://github.com/chenq182/NOTE

sed -i '/# Symbolic Links #/{p;:a;N;$!ba;d}' .gitignore
find . -type l | sed -e s'/^\.\///g' >>.gitignore

git add .
git commit -m "$(date "+%Y-%m-%d %H:%M:%S")"
git push origin master

# vim: set tabstop=4 shiftwidth=4:
