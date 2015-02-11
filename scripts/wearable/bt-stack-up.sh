#!/bin/sh

HCIDUMP_DIR="/opt/usr/media/.bluetooth"
HCIDUMP_FILENAME="bt_hcidump.log"
HCIDUMP_PATH="${HCIDUMP_DIR}/${HCIDUMP_FILENAME}"
LOGDUMP_DIR="/opt/etc/dump.d/module.d"
LOGDUMP_PATH="${LOGDUMP_DIR}/bt-hci-logdump.sh"

/usr/bin/bluetooth-hf-agent &
#
# Script for executing Bluetooth stack
#

# Register BT Device
/usr/etc/bluetooth/bt-dev-start.sh

if !(/usr/bin/hciconfig | grep hci); then
	echo "Registering BT device is failed."
	exit 1
fi

debug_mode=`cat /sys/module/sec_debug/parameters/enable`
debug_mode_user=`cat /sys/module/sec_debug/parameters/enable_user`

if [ ${debug_mode} = '1' -o ${debug_mode_user} = '1' ]
then
	if [ -e /usr/sbin/hcidump ]
	then
		# When *#9900# is typed, this is executed to archive logs. #
		/bin/mkdir -p ${LOGDUMP_DIR}
		/bin/cp -f /usr/etc/bluetooth/bt-hci-logdump.sh ${LOGDUMP_PATH}

		/bin/mkdir -p ${HCIDUMP_DIR}/old_hcidump
		/bin/rm -f ${HCIDUMP_DIR}/old_hcidump/*
		/bin/mv ${HCIDUMP_PATH}* ${HCIDUMP_DIR}/old_hcidump/
		/usr/sbin/hcidump -w ${HCIDUMP_PATH} &
	fi
elif [ -e ${HCIDUMP_DIR} ]
then
	/bin/rm -rf ${HCIDUMP_DIR}
fi

# Execute BlueZ BT stack
echo "Run bluetoothd"
/usr/lib/bluetooth/bluetoothd -d -C &
/usr/bin/dbus-send --print-reply --system --type=method_call \
		--dest=org.freedesktop.systemd1 /org/freedesktop/systemd1 \
		org.freedesktop.systemd1.Manager.StartUnit \
		string:'wms.service' string:'fail'

exit 0
