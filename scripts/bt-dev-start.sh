#!/bin/sh
PATH=/bin:/usr/bin:/sbin:/usr/sbin

# Script for registering BT device
BT_PLATFORM_DEFAULT_HCI_NAME="Tizen"

# Turn-on Bluetooth Chip

/usr/sbin/rfkill unblock bluetooth

echo "Check for Bluetooth device status"
if (/usr/bin/hciconfig | grep hci); then
	echo "Bluetooth device is UP"
	/usr/bin/hciconfig hci0 up
else
	echo "Bluetooth device is DOWN"
	echo "Registering Bluetooth device"
	/usr/bin/hciconfig hci0 up
	/usr/bin/hciconfig hci0 name $BT_PLATFORM_DEFAULT_HCI_NAME
	/usr/bin/hciconfig hci0 sspmode 1
fi
