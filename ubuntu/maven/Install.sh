#!/bin/bash

set -o nounset
cd $(dirname $0)

##################################################
# Ubuntu 16.04 specific settings
##################################################

DES_PATH="/usr/share"
DES_NAME="maven"
PKG_URL="http://mirror.bit.edu.cn/apache/maven/maven-3/3.5.2/binaries/apache-maven-3.5.2-bin.tar.gz"
PKG_NAME="apache-maven-3.5.2"

InstallCFGs() {
    ln -s ${DES_PATH}/${DES_NAME}/bin/mvn /usr/local/bin
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
    PKG_FILE=${PKG_URL##*/}
    if [ -z "$PKG_NAME" ];then
        PKG_NAME=${PKG_FILE%%.tar*}
    fi

    if [ -f "${PKG_FILE}" ];then
        Error "${PKG_FILE} exists."
        exit 1
    else
        wget -c ${PKG_URL}
    fi
Done

Step "Install PKG"
    tar zxvf ${PKG_FILE} -C ${DES_PATH}/
    echo -n "" >${PKG_FILE}
    mv ${DES_PATH}/${PKG_NAME} ${DES_PATH}/${DES_NAME}
Done

Step "Install config files"
    InstallCFGs
Done

Message "FINISHED."

# vim: set tabstop=4 shiftwidth=4:
