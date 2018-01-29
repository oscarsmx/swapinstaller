#!/bin/bash
# SWAP MAKER 1.0
# Tested on CentOS 7.x and Ubuntu 17.04
# Author OscarS.
# http://www.oscars.mx

{
if [[ $(swapon -s) ]]; then
	echo "ERROR. THERE IS SOME SWAP IN THE SYSTEM"
else
	echo "#########################"
	echo "Installing a 4GB SWAP file to the system"
	dd if=/dev/zero of=/swapfile bs=1M count=4048
	mkswap /swapfile
	swapon /swapfile
	chmod 600 /swapfile
	echo "/swapfile swap swap    0   0" >> /etc/fstab
	echo "SWAP Installed. Log at /var/log/swapinstaller.log"
fi
} 2>&1 | tee /var/log/swapinstaller.log