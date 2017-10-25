@echo off

adb root

::adb shell mount -o rw,remount /
::adb push ../../bin/busybox /sbin/
::adb shell chmod a+x /sbin/busybox

adb push ../../sdcard /

adb push ../../bin /data/udroid/usr/local
adb shell busybox chmod -R a+x /data/udroid/usr/local/bin

adb shell busybox umount /data/udroid/sdcard
adb shell busybox umount /data/udroid/system
adb shell busybox umount /data/udroid/sys/kernel/debug
adb shell busybox umount /data/udroid/sys/fs/selinux
adb shell busybox umount /data/udroid/sys
adb shell busybox umount /data/udroid/dev/pts
adb shell busybox umount /data/udroid/dev
adb shell busybox umount /data/udroid/proc

adb shell busybox mount -o bind /proc /data/udroid/proc
adb shell busybox mount -o bind /dev /data/udroid/dev
adb shell busybox mount -o bind /dev/pts /data/udroid/dev/pts
adb shell busybox mount -o bind /sys /data/udroid/sys
adb shell busybox mount -o bind /sys/fs/selinux /data/udroid/sys/fs/selinux
adb shell busybox mount -o bind /sys/kernel/debug /data/udroid/sys/kernel/debug
adb shell busybox mkdir -p /data/udroid/system
adb shell busybox mkdir -p /data/udroid/sdcard
adb shell busybox mount -o bind /system/ /data/udroid/system
adb shell busybox mount -o bind /sdcard /data/udroid/sdcard

adb shell busybox cp -f property_contexts /data/udroid/
adb shell busybox cp -f seapp_contexts /data/udroid/
adb shell busybox cp -f selinux_version /data/udroid/
adb shell busybox cp -f sepolicy /data/udroid/
adb shell busybox cp -f service_contexts /data/udroid/

adb push ../../root  /data/udroid/
