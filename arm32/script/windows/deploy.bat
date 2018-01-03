@echo off

adb root

adb push ../../sdcard     /
adb push ../../udroid     /data/ubuntu/usr/local
adb push ../../root       /data/ubuntu/

adb shell /system/bin/toybox chmod -R a+x /data/ubuntu/usr/local/udroid/bin
adb shell /system/bin/toybox chmod -R a+x /data/ubuntu/usr/local/udroid/shell
adb shell /system/bin/toybox chmod -R a+x /data/ubuntu/usr/local/udroid/python
adb shell /system/bin/toybox chmod -R a+x /data/ubuntu/usr/local/udroid/link
adb shell /system/bin/toybox chmod -R a+x /data/ubuntu/usr/local/udroid/wrapper
