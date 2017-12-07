#!/bin/bash

set -o nounset
cd $(dirname $0)

##################################################
# Ubuntu 16.04 specific settings
# http://blog.csdn.net/jun2016425/article/details/52858084
##################################################

LOCAL_GROUP=share
LOCAL_USER=share
# /var/cache/apt/archives
# apt-get install samba
# apt-get install smbclient
# https://packages.ubuntu.com/xenial/amd64/samba/download
# https://packages.ubuntu.com/xenial/amd64/smbclient/download
DEB_LIST=(\
"" \
"" \
"" \
"" \
"" \
"" \
)

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

for pkg in ${DEB_LIST[@]};do
Step "Install PKG <$pkg>"
    PKG_FILE=${pkg##*/}
    dpkg -i $PKG_FILE
    if [[ $? != 0 ]]; then
        Error "Installation failed! Please install the package <$pkg> manually."
        exit 1
    fi
Done
done

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
