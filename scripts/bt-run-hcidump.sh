#!/bin/sh

HCIDUMP_BASEDIR="/opt/usr/media/Others"
HCIDUMP_DIR="${HCIDUMP_BASEDIR}/.bt_dump"
HCIDUMP_FILENAME="bt_hcidump.log"
HCIDUMP_PATH="${HCIDUMP_DIR}/${HCIDUMP_FILENAME}"

LOGDUMP_DIR="/opt/etc/dump.d/module.d"
LOGDUMP_PATH="${LOGDUMP_DIR}/bt-hci-logdump.sh"

debug_mode=`/bin/cat /sys/module/sec_debug/parameters/enable`
debug_mode_user=`/bin/cat /sys/module/sec_debug/parameters/enable_user`

if [ ${debug_mode} = '1' -o ${debug_mode_user} = '1' ]
then
	if [ -e /usr/sbin/hcidump ]
	then
		# When *#9900# is typed, this is executed to archive logs.
		/bin/mkdir -p ${LOGDUMP_DIR}
		/bin/cp -f /usr/etc/bluetooth/bt-hci-logdump.sh ${LOGDUMP_PATH}

		# Create base directory as proper owner and smack rule
		# if it doesn't exist
		if [ ! -e ${HCIDUMP_BASEDIR} ]
		then
			/bin/mkdir - p ${HCIDUMP_BASEDIR}
			/bin/chown 5000:5000 ${HCIDUMP_BASEDIR}
			/usr/bin/chsmack -t -a 'system::media' ${HCIDUMP_BASEDIR}
		fi
		/bin/mkdir -p ${HCIDUMP_DIR}/old_hcidump
		/bin/rm -f ${HCIDUMP_DIR}/old_hcidump/*
		/bin/mv ${HCIDUMP_PATH}* ${HCIDUMP_DIR}/old_hcidump/
		/usr/sbin/hcidump -w ${HCIDUMP_PATH} &
	fi
elif [ -e ${HCIDUMP_DIR} ]
then
	/bin/rm -rf ${HCIDUMP_DIR}
fi
