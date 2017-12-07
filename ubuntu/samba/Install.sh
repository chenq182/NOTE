#!/bin/bash

set -o nounset
cd $(dirname $0)

##################################################
# Ubuntu 16.04 specific settings
# http://blog.csdn.net/jun2016425/article/details/52858084
##################################################

LOCAL_GROUP=share
LOCAL_USER=share
# https://packages.ubuntu.com/xenial/amd64/samba/download
PKG_samba_URL="http://security.ubuntu.com/ubuntu/pool/main/s/samba/samba_4.3.11+dfsg-0ubuntu0.16.04.12_amd64.deb"
# https://packages.ubuntu.com/xenial/amd64/smbclient/download
PKG_smbclient_URL="http://security.ubuntu.com/ubuntu/pool/main/s/samba/smbclient_4.3.11+dfsg-0ubuntu0.16.04.12_amd64.deb"

InstallCFGs() {
    Backup /etc/samba/smb.conf
    cat conf/smb.conf >> /etc/samba/smb.conf
    sudo /etc/init.d/samba restart
}

##################################################
# Common functions and variables
##################################################

source ../.utils/common_functions

##################################################
# Script body
##################################################

Step "Check for root privileges"
    if [[ "$UID" != 0 ]];then
        Error "You don't have root privileges. Please use sudo."
        exit 1
    fi
Done

Step "Downloading PKG <samba>"
    PKG_URL=${PKG_samba_URL}
    PKG_FILE=${PKG_URL##*/}
    if [ -f "${PKG_FILE}" ];then
        Error "${PKG_FILE} exists."
    else
        wget -c ${PKG_URL}
    fi
Done
Step "Install PKG <samba>"
    dpkg -i $PKG_FILE
Done

Step "Downloading PKG <smbclient>"
    PKG_URL=${PKG_smbclient_URL}
    PKG_FILE=${PKG_URL##*/}
    if [ -f "${PKG_FILE}" ];then
        Error "${PKG_FILE} exists."
    else
        wget -c ${PKG_URL}
    fi
Done
Step "Install PKG <smbclient>"
    dpkg -i $PKG_FILE
Done

# http://blog.csdn.net/bluishglc/article/details/42060223
Step "Create local user"
    #create group if not exists
    egrep "^$LOCAL_GROUP" /etc/group >& /dev/null
    if [ $? -ne 0 ];then
        groupadd $LOCAL_GROUP
    fi
    #create user if not exists
    egrep "^$LOCAL_USER" /etc/passwd >& /dev/null
    if [ $? -ne 0 ];then
        useradd -g $LOCAL_GROUP $LOCAL_USER -s /sbin/nologin -d /dev/null
    fi
Done

Step "Configure SMB password"
    sudo smbpasswd -a $LOCAL_USER
Done

Step "Install config files"
    InstallCFGs
Done

Message "FINISHED."
