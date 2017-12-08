@echo off

adb root

::set up term for android host adb
adb install Term.apk
adb push adb /data/user/0/jackpal.androidterm/app_HOME/
adb shell /system/bin/toybox chmod a+x /data/user/0/jackpal.androidterm/app_HOME/adb
adb shell setprop persist.adb.tcp.port 5555

::unzip ubuntu rootfs
adb push busybox /data/local/tmp/
adb shell /system/bin/toybox chmod a+x /data/local/tmp/busybox
adb shell /data/local/tmp/busybox mkdir -p /data/ubuntu
adb push  ubuntu.tar.gz /data/ubuntu
adb shell /data/local/tmp/busybox tar -zxvf /data/ubuntu/ubuntu.tar.gz -C /data/ubuntu
