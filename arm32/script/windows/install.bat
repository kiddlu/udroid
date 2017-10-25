@echo off

adb root
adb remount
adb push ../../bin/busybox /system/bin/

adb shell busybox mkdir -p /data/udroid
adb push ..\..\dist\udroid.tar.gz /data/udroid
adb shell busybox tar -zxvf /data/udroid/udroid.tar.gz -C /data/udroid
