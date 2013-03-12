#!/bin/sh

# BT Stack and device stop
/usr/etc/bluetooth/bt-stack-down.sh

killall -9 hciattach

# Remove BT files and setting
rm -rf /opt/data/bluetooth/.bt_paired
rm -rf /var/lib/bluetooth/*

# Initialize BT vconf values
vconftool set -tf int db/bluetooth/status "0" -g 6520
vconftool set -tf int file/private/bt-service/flight_mode_deactivated "0" -g 6520 -i
vconftool set -tf string memory/bluetooth/sco_headset_name "" -g 6520 -i
vconftool set -tf int memory/bluetooth/device "0" -g 6520 -i
vconftool set -tf int memory/bluetooth/btsco "0" -g 6520 -i
vconftool set -tf int file/private/libug-setting-bluetooth-efl/visibility_time "0" -g 6520
vconftool set -tf bool memory/private/bluetooth-share/quickpanel_clear_btn_status FALSE -g 6520 -i
vconftool set -tf bool memory/private/bluetooth-share/opp_server_init FALSE -g 6520 -i

# Remove BT shared memory
list=`ipcs -m | awk '$1==0x0001000 {print $2}'`
for i in $list
do
	ipcrm -m $i
done
ipcs -m | grep "0x00001000" | awk '{ print $2 }'
