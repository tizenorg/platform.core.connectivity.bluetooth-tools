#!/bin/sh

#
# Script for turning on Bluetooth EDUTM
#

# Register BT Device
/usr/etc/bluetooth/bt-dev-start.sh

if !(/usr/sbin/hciconfig | grep hci); then
	echo "BT EDUTM failed. Registering BT device is failed."
	exit 1
fi

# Execute BlueZ BT stack
echo "Run bluetoothd"
/usr/sbin/bluetoothd
/usr/bin/bt-service &
sleep 0.1

/usr/sbin/hciconfig hci0 name TIZEN-Mobile

/usr/sbin/hciconfig hci0 piscan

if [ -e "/sys/devices/hci0/idle_timeout" ]
then
	echo "Set idle time"
	echo 0> /sys/devices/hci0/idle_timeout
fi

if [ -e /usr/etc/bluetooth/TIInit_* ]
then
	echo "Reset device"
	hcitool cmd 0x3 0xFD0C
fi

echo "Configure BT device"
hcitool cmd 0x3 0x0005 0x02 0x00 0x02

echo "Send BT edutm command"
hcitool cmd 0x06 0x0003

echo "BT edutm done"

# result
exit 0
