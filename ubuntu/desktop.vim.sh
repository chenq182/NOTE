#!/bin/bash

set -o nounset
cd $(dirname $0)

##################################################
# Common functions and variables
##################################################

source .utils/common_functions

##################################################
# Script body
##################################################

Step "Check for root privileges"
    if [[ "$UID" != 0 ]]; then
        Error "You don't have root privileges. Please use sudo."
        exit 1
    fi
Done

Step "Update packages"
    apt-get update
Done

Step "Upgrade packages"
    apt-get upgrade
Done

Step "Vim configuration"
    apt-get install vim
    echo -e "set nu\nset noai nosi" > ~/.vimrc
Done

Message "FINISHED."
