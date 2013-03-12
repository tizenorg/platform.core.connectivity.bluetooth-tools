#!/bin/sh

#
# Script for turning off Bluetooth(EDUTM)
#

# Kill BlueZ bluetooth stack
killall bluetoothd

# Remove BT device
/usr/etc/bluetooth/bt-dev-end.sh

# result
exit 0
