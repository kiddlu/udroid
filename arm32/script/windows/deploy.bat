@echo off

adb root

adb shell mount -o rw,remount /
adb push ../../bin/busybox /sbin/
adb push ../../bin/ubuntu /sbin/
adb shell chmod -R a+x /sbin/

adb push ../../bin/capture.sh /data/ubuntu/usr/local/bin
adb push ../../bin/fbn.sh     /data/ubuntu/usr/local/bin
adb push ../../bin/setdns.sh /data/ubuntu/usr/local/bin

adb shell busybox chmod -R a+x /data/ubuntu/usr/local/bin

adb shell busybox umount /data/ubuntu/sdcard
adb shell busybox umount /data/ubuntu/system
adb shell busybox umount /data/ubuntu/tmp
adb shell busybox umount /data/ubuntu/run
adb shell busybox umount /data/ubuntu/sys/kernel/debug
adb shell busybox umount /data/ubuntu/sys/fs/selinux
adb shell busybox umount /data/ubuntu/sys
adb shell busybox umount /data/ubuntu/dev
adb shell busybox umount /data/ubuntu/proc

adb shell busybox mount -o bind /proc /data/ubuntu/proc
adb shell busybox mount -o bind /dev /data/ubuntu/dev
adb shell busybox mount -o bind /sys /data/ubuntu/sys
adb shell busybox mount -o bind /sys/fs/selinux /data/ubuntu/sys/fs/selinux
adb shell busybox mount -o bind /sys/kernel/debug /data/ubuntu/sys/kernel/debug
adb shell busybox mount -t tmpfs none /data/ubuntu/run
adb shell busybox mount -t tmpfs none /data/ubuntu/tmp
adb shell busybox mkdir -p /data/ubuntu/system
adb shell busybox mkdir -p /data/ubuntu/sdcard
adb shell busybox mount -o bind /system/ /data/ubuntu/system
adb shell busybox mount -o bind /sdcard /data/ubuntu/sdcard

adb shell busybox cp -f property_contexts /data/ubuntu/
adb shell busybox cp -f seapp_contexts /data/ubuntu/
adb shell busybox cp -f selinux_version /data/ubuntu/
adb shell busybox cp -f sepolicy /data/ubuntu/
adb shell busybox cp -f service_contexts /data/ubuntu/

adb push ../../home/.bashrc /data/ubuntu/root
adb push ../../home/.inputrc /data/ubuntu/root
adb push ../../home/.vimrc /data/ubuntu/root