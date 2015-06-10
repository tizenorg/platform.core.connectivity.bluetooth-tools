#!/bin/sh

#
# Script for stopping Bluetooth stack
#

# Remove BT device
/usr/etc/bluetooth/bt-dev-end.sh

# Kill BlueZ bluetooth stack
killall obexd obex-client
killall bt-syspopup
killall bluetooth-pb-agent
killall bluetooth-map-agent
killall bluetooth-hfp-agent
killall bluetoothd

# result
exit 0