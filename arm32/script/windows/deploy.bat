@echo off

adb root

adb push ../../sdcard     /
adb push ../../udroid    /data/ubuntu/usr/local
adb push ../../root       /data/ubuntu/

adb shell /system/bin/toybox chmod -R a+x /data/ubuntu/usr/local/android/bin
adb shell /system/bin/toybox chmod -R a+x /data/ubuntu/usr/local/android/shell
adb shell /system/bin/toybox chmod -R a+x /data/ubuntu/usr/local/android/link
adb shell /system/bin/toybox chmod -R a+x /data/ubuntu/usr/local/android/wrapper

adb shell /system/bin/toybox mkdir -p /data/ubuntu/system
adb shell /system/bin/toybox mkdir -p /data/ubuntu/sdcard
