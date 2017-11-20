@echo off

adb root

adb push ../../sdcard     /
adb push ../../bin        /data/ubuntu/usr/local
adb push ../../android    /data/ubuntu/usr/local
adb push ../../wrapper    /data/ubuntu/usr/local
adb push ../../root       /data/ubuntu/

adb shell /system/bin/toybox chmod -R a+x /data/ubuntu/usr/local/bin
adb shell /system/bin/toybox chmod -R a+x /data/ubuntu/usr/local/android/bin
adb shell /system/bin/toybox chmod -R a+x /data/ubuntu/usr/local/wrapper
adb shell /system/bin/toybox mkdir -p /data/ubuntu/system
adb shell /system/bin/toybox mkdir -p /data/ubuntu/sdcard

adb shell /system/bin/toybox cp -f property_contexts /data/ubuntu/
adb shell /system/bin/toybox cp -f seapp_contexts /data/ubuntu/
adb shell /system/bin/toybox cp -f selinux_version /data/ubuntu/
adb shell /system/bin/toybox cp -f sepolicy /data/ubuntu/
adb shell /system/bin/toybox cp -f service_contexts /data/ubuntu/
adb shell /system/bin/toybox cp -rf /data/ubuntu/etc /data/ubuntu/etc.bak
adb shell /system/bin/toybox cp -Lrf /system/etc/* /data/ubuntu/etc/
adb shell /system/bin/toybox cp -Lrf /sbin/* /data/ubuntu/sbin/
