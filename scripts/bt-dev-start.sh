#!/bin/sh

# Script for registering BT device
BT_PLATFORM_DEFAULT_HCI_NAME="Tizen"

# Trun-on Bluetooth Chip

/usr/sbin/rfkill unblock bluetooth

echo "Check for Bluetooth device status"
if (/usr/sbin/hciconfig | grep hci); then
	echo "Bluetooth device is UP"
	/usr/sbin/hciconfig hci0 up
else
	echo "Bluetooth device is DOWN"
	echo "Registering Bluetooth device"
	/usr/sbin/hciconfig hci0 up
	/usr/sbin/hciconfig hci0 name $BT_PLATFORM_DEFAULT_HCI_NAME
	/usr/sbin/hciconfig hci0 sspmode 1
fi
