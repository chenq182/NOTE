#!/bin/bash

set -o nounset
cd $(dirname $0)

##################################################
# Ubuntu 16.04 specific settings
##################################################

DES_PATH="/usr/share"
DES_NAME="java"
PKG_URL="http://download.java.net/java/jdk8u162/archive/b01/binaries/jdk-8u162-ea-bin-b01-linux-x64-04_oct_2017.tar.gz"
PKG_NAME="jdk1.8.0_162"

InstallCFGs() {
    Backup /etc/profile
    sed -i '/# JAVA BEGIN #/{x;:a;N;/# JAVA END #/!ba;d}' /etc/profile
    echo "# JAVA BEGIN #" >>/etc/profile
    echo -e "export JAVA_HOME=${DES_PATH}/${DES_NAME}" >>/etc/profile
    echo "export JRE_HOME=\${JAVA_HOME}/jre" >>/etc/profile
    echo "# JAVA END #" >>/etc/profile

    ln -s ${DES_PATH}/${DES_NAME}/bin/java /usr/local/bin
    ln -s ${DES_PATH}/${DES_NAME}/bin/javac /usr/local/bin
    ln -s ${DES_PATH}/${DES_NAME}/bin/javah /usr/local/bin
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
    rm -rf ${DES_PATH}/${DES_NAME}
    mv ${DES_PATH}/${PKG_NAME} ${DES_PATH}/${DES_NAME}
Done

Step "Install config files"
    InstallCFGs
Done

Message "FINISHED.(Reboot needed.)"

# vim: set tabstop=4 shiftwidth=4:
