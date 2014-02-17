#!/bin/sh

#
# Script for executing Bluetooth stack
#

# Register BT Device
/usr/etc/bluetooth/bt-dev-start.sh

if !(/usr/bin/hciconfig | grep hci); then
	echo "Registering BT device failed."
	exit 1
fi

# Execute BlueZ BT stack
echo "Run bluetoothd"

# We have to handle both systemd and sysvinit cases differently
if [ -d /sys/fs/cgroup/systemd ]; then
   # bt-service changes USER via libprivilege-control, so it needs
   # to know where the session bus is located under systemd
   export DBUS_SESSION_BUS_ADDRESS=unix:path=$XDG_RUNTIME_DIR/dbus/user_bus_socket
else
   # Under systemd, bluetoothd is dbus activated. sysvinit requires it to be
   # launched explicitly
   /lib/bluetooth/bluetoothd -E
fi

/usr/bin/bt-service &
/usr/bin/bluetooth-share &

exit 0
