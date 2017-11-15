@echo off

adb root

adb push busybox /data/local/tmp/

adb shell /system/bin/toybox chmod a+x /data/local/tmp/busybox
adb shell /data/local/tmp/busybox mkdir -p /data/ubuntu
adb push  ubuntu.tar.gz /data/ubuntu
adb shell /data/local/tmp/busybox tar -zxvf /data/ubuntu/ubuntu.tar.gz -C /data/ubuntu
