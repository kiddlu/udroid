@echo off

adb root
adb remount
adb push busybox /system/bin/

adb shell busybox mkdir -p /data/ubuntu
adb push  ubuntu.tar.gz /data/ubuntu
adb shell busybox tar -zxvf /data/ubuntu/ubuntu.tar.gz -C /data/ubuntu
