#!/bin/sh

#
# Script for turning on Bluetooth (EDUTM)
#

if /usr/sbin/hciconfig | grep hci; then
	/usr/etc/bluetooth/bt-stack-down.sh
	sleep 1
fi

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
