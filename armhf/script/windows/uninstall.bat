@echo off

adb root

adb push ../../bin/busybox /system/bin/


adb shell busybox umount /data/ubuntu/sdcard
adb shell busybox umount /data/ubuntu/system
adb shell busybox umount /data/ubuntu/sys/kernel/debug
adb shell busybox umount /data/ubuntu/sys/fs/selinux
adb shell busybox umount /data/ubuntu/sys
adb shell busybox umount /data/ubuntu/dev
adb shell busybox umount /data/ubuntu/proc
