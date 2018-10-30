#!/bin/bash
# SWAP INSTALLER 2.0
# Tested on CentOS 7.x and Ubuntu 18.04
# Author OscarS.
# http://www.oscars.mx

checkswap() {
if $(free | awk '/^Swap:/ {exit !$2}'); then
    echo "there is already some Swap. Exitting..."
    echo "$(free | awk '/^Swap:/')"
    exit
else
    echo "there is no Swap."
    echo "$(free | awk '/^Swap:/')"
    echo "Starting script..."
fi
}

install() {
checkswap
    echo "Insert MBs to allocate swap (i.e. 4096 = 4GB only numbers please)"
    echo "Remember that this will be taken from your HD so if you have 25GB and need 5GB swap you will have only 20GB after this script"
    read swapsize
    echo "creating file"
    dd if=/dev/zero of=/swapfile bs=1M count=$swapsize
    echo "installing swap"
    mkswap /swapfile
    swapon /swapfile
    chmod 600 /swapfile
    echo "/swapfile swap swap    0   0" >> /etc/fstab
    echo "SWAP installed at /swapfile with $swapsize MBs of size"
    echo "Bye bye"
    exit
}
install