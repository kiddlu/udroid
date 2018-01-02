#!/bin/bash

set -x

adb shell cat /data/user/0/jackpal.androidterm/app_HOME/.android/adbkey.pub >> /data/misc/adb/adb_keys
