@echo off

adb root

::adb shell mount -o rw,remount /
::adb push ../../bin/busybox /sbin/
::adb shell chmod a+x /sbin/busybox

adb push ../../sdcard /

adb push ../../bin /data/ubuntu/usr/local
adb shell busybox chmod -R a+x /data/ubuntu/usr/local/bin

adb shell busybox umount /data/ubuntu/sdcard
adb shell busybox umount /data/ubuntu/system
adb shell busybox umount /data/ubuntu/sys/kernel/debug
adb shell busybox umount /data/ubuntu/sys/fs/selinux
adb shell busybox umount /data/ubuntu/sys
adb shell busybox umount /data/ubuntu/dev/pts
adb shell busybox umount /data/ubuntu/dev
adb shell busybox umount /data/ubuntu/proc

adb shell busybox mount -o bind /proc /data/ubuntu/proc
adb shell busybox mount -o bind /dev /data/ubuntu/dev
adb shell busybox mount -o bind /dev/pts /data/ubuntu/dev/pts
adb shell busybox mount -o bind /sys /data/ubuntu/sys
adb shell busybox mount -o bind /sys/fs/selinux /data/ubuntu/sys/fs/selinux
adb shell busybox mount -o bind /sys/kernel/debug /data/ubuntu/sys/kernel/debug
adb shell busybox mkdir -p /data/ubuntu/system
adb shell busybox mkdir -p /data/ubuntu/sdcard
adb shell busybox mount -o bind /system/ /data/ubuntu/system
adb shell busybox mount -o bind /sdcard /data/ubuntu/sdcard

adb shell busybox cp -f property_contexts /data/ubuntu/
adb shell busybox cp -f seapp_contexts /data/ubuntu/
adb shell busybox cp -f selinux_version /data/ubuntu/
adb shell busybox cp -f sepolicy /data/ubuntu/
adb shell busybox cp -f service_contexts /data/ubuntu/

adb push ../../root  /data/ubuntu/
