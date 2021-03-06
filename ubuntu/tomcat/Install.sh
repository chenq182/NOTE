#!/bin/bash

set -o nounset
cd $(dirname $0)

##################################################
# Ubuntu 16.04 specific settings
##################################################

DES_PATH="/usr/share"
DES_NAME="tomcat9"
PKG_FILE="apache-tomcat-9.0.1.tar.gz"

InstallCFGs() {
    Backup ${DES_PATH}/${DES_NAME}/conf/server.xml
    sed -i 's/8080/80/' ${DES_PATH}/${DES_NAME}/conf/server.xml

    ln -s ${DES_PATH}/${DES_NAME}/bin/startup.sh
    ln -s ${DES_PATH}/${DES_NAME}/bin/shutdown.sh
    ln -s ${DES_PATH}/${DES_NAME}/webapps
    ln -s ${DES_PATH}/${DES_NAME}/logs
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

Step "Downloading PKG"
    PKG_NAME=${PKG_FILE%%.tar*}
    if [! -f "${PKG_FILE}" ];then
        Error "${PKG_FILE} doesn't exist."
        exit 1
    fi
Done

Step "Install PKG"
    tar zxvf ${PKG_FILE} -C ${DES_PATH}/
    rm -rf ${DES_PATH}/${DES_NAME}
    mv ${DES_PATH}/${PKG_NAME} ${DES_PATH}/${DES_NAME}
Done

Step "Install config files"
    InstallCFGs
Done

Message "FINISHED."

# vim: set tabstop=4 shiftwidth=4:
