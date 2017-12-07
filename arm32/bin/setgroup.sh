#!/bin/bash

groupadd -g 1000 system
groupadd -g 1004 android_input
groupadd -g 1007 log
groupadd -g 1011 adb
groupadd -g 1015 sdcard_rw
groupadd -g 1028 sdcard_r
groupadd -g 2000 shell
groupadd -g 3001 net_bt_admin
groupadd -g 3002 net_bt
groupadd -g 3003 inet
groupadd -g 3006 net_bw_stats

usermod -a -G android_input root 
usermod -a -G log root
usermod -a -G adb root
usermod -a -G sdcard_rw root
usermod -a -G sdcard_r root
usermod -a -G net_bt_admin root
usermod -a -G net_bt root
usermod -a -G inet root
usermod -a -G net_bw_stats root

sed -i "s/_apt:x:105:65534/_apt:x:105:3003/" /etc/passwd
