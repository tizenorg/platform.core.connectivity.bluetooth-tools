#!/bin/sh
PATH=/bin:/usr/bin:/sbin:/usr/sbin

#
# Script for stopping Bluetooth stack
#

# Device down
/usr/bin/hciconfig hci0 down

# Turn off Bluetooth Chip
/usr/sbin/rfkill block bluetooth
