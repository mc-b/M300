#!/bin/bash
#
# Grundkonfiguration OS
#

# Change hostname	
export NEW_HOSTNAME=iot-stick
export CURRENT_HOSTNAME=`cat /etc/hostname | tr -d " \t\n\r"`
echo $NEW_HOSTNAME > /etc/hostname
sed -i "s/127.0.1.1.*$CURRENT_HOSTNAME/127.0.1.1\t$NEW_HOSTNAME/g" /etc/hosts

# Hilfsprogramme
sudo apt-get install -y autossh

