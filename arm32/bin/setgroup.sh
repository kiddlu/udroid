#!/bin/bash

groupadd -g 1004 input
groupadd -g 1007 log
groupadd -g 1011 adb
groupadd -g 1015 sdcard_rw
groupadd -g 1028 sdcard_r
groupadd -g 3001 net_bt_admin
groupadd -g 3002 net_bt
groupadd -g 3003 inet
groupadd -g 3006 net_bw_stats

usermod -a -G input log adb sdcard_rw sdcard_r net_bt_admin net_bt inet net_bw_stats root

echo "/system/bin/id to check"
echo "vim /etc/passwd change the group of _apt from 65534 to 3003"