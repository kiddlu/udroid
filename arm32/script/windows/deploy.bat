@echo off

adb root
adb remount
adb push ../../bin/busybox /system/bin/
adb push ../../bin/ubuntu /system/bin/

adb push ../../bin/capture.sh /data/ubuntu/usr/local/bin
adb push ../../bin/fbn.sh     /data/ubuntu/usr/local/bin
adb push ../../bin/set-resolv.sh /data/ubuntu/usr/local/bin

adb shell busybox chmod -R a+x /data/ubuntu/usr/local/bin

adb shell busybox umount /data/ubuntu/system/
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

adb shell busybox mkdir -p /data/ubuntu/system
adb shell busybox mount -o bind /system/ /data/ubuntu/system/

adb shell busybox cp -f property_contexts /data/ubuntu/
adb shell busybox cp -f seapp_contexts /data/ubuntu/
adb shell busybox cp -f selinux_version /data/ubuntu/
adb shell busybox cp -f sepolicy /data/ubuntu/
adb shell busybox cp -f service_contexts /data/ubuntu/

adb push ../../home/.bashrc /data/ubuntu/root
adb push ../../home/.inputrc /data/ubuntu/root
adb push ../../home/.vimrc /data/ubuntu/root