#!/bin/bash

set -o nounset
cd $(dirname $0)

##################################################
# Ubuntu 16.04 specific settings
##################################################

PKG_LIST=("mysql-server")
PKG_INSTALL="apt-get install"

InstallCFGs() {
    cp /etc/mysql/mysql.conf.d/mysqld.cnf /etc/mysql/my.cnf
    sed -i '/\[mysqld\]/a\character_set_server=utf8\ncollation-server=utf8_general_ci' \
        /etc/mysql/my.cnf
    sed -i 's/^.*bind-address/# bind-address/g' /etc/mysql/my.cnf
}

##################################################
# Common functions and variables
##################################################

source ../.utils/common_functions

##################################################
# Script body
##################################################

Step "Check for root privileges"
    if [[ "$UID" != 0 ]]; then
        Error "You don't have root privileges. Please use sudo."
        exit 1
    fi
Done

Step "Install required packages"
    Message "The script will try to install the following packages:"
    for pkg in ${PKG_LIST[@]}; do
        Message " - $pkg"
    done
    $PKG_INSTALL ${PKG_LIST[@]}
    if [[ $? != 0 ]]; then
        Error "Installation failed! Please install the packages manually."
        exit 1
    fi
Done

Step "Install config files"
    InstallCFGs
Done

Step "Restart service"
    service mysql restart
Done

Message "FINISHED."

# vim: set tabstop=4 shiftwidth=4:
