@echo off

adb root

adb push ../../bin/busybox /system/bin/


adb shell busybox umount /data/udroid/sdcard
adb shell busybox umount /data/udroid/system
adb shell busybox umount /data/udroid/sys/kernel/debug
adb shell busybox umount /data/udroid/sys/fs/selinux
adb shell busybox umount /data/udroid/sys
adb shell busybox umount /data/udroid/dev
adb shell busybox umount /data/udroid/proc
