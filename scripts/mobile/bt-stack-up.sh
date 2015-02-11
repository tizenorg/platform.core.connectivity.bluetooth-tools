#!/bin/sh

#
# Script for executing Bluetooth stack
#

# Register BT Device
/usr/etc/bluetooth/bt-dev-start.sh

if !(/usr/bin/hciconfig | grep hci); then
	echo "Registering BT device is failed."
	exit 1
fi

# We have to handle both systemd and sysvinit cases differently
if [ -d /sys/fs/cgroup/systemd ]; then
   # bt-service changes USER to 'app' via libprivilege-control, so it needs
   # to know where the session bus is located under systemd
   export DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/app/dbus/user_bus_socket
fi

# Execute BlueZ BT stack
echo "Run bluetoothd"
/usr/lib/bluetooth/bluetoothd -d -C &
/usr/bin/bluetooth-share &

exit 0
