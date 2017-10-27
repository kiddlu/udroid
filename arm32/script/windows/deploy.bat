@echo off

adb root

adb push ../../sdcard     /
adb push ../../bin        /data/udroid/usr/local
adb push ../../android    /data/udroid/usr/local
adb push ../../root       /data/udroid/

adb shell /system/bin/toybox chmod -R a+x /data/udroid/usr/local/bin
adb shell /system/bin/toybox chmod -R a+x /data/udroid/usr/local/android/bin
adb shell /system/bin/toybox mkdir -p /data/udroid/system
adb shell /system/bin/toybox mkdir -p /data/udroid/sdcard

adb shell /system/bin/toybox cp -f property_contexts /data/udroid/
adb shell /system/bin/toybox cp -f seapp_contexts /data/udroid/
adb shell /system/bin/toybox cp -f selinux_version /data/udroid/
adb shell /system/bin/toybox cp -f sepolicy /data/udroid/
adb shell /system/bin/toybox cp -f service_contexts /data/udroid/
