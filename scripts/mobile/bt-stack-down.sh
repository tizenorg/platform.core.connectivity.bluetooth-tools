#!/bin/sh
PATH=/bin:/usr/bin:/sbin:/usr/sbin

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
killall bluetooth-ag-agent
killall bluetoothd
killall bluetooth-share

# result
exit 0
