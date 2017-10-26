#!/bin/bash

set -x

ln -sf /system/fonts /usr/share/fonts/truetype/android-font
fc-cache -fv
