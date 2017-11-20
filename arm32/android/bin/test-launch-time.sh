#!/bin/bash

echo -e '\n' 
echo ============drop_cache time================
am force-stop com.tencent.mm
echo 3 > /proc/sys/vm/drop_caches
am start -W com.tencent.mm/.ui.LauncherUI

echo -e '\n' 
echo ==============cold time===================
am force-stop com.tencent.mm
am start -W com.tencent.mm/.ui.LauncherUI

echo -e '\n' 
echo ==============hot time===================
input keyevent KEYCODE_HOME
am start -W com.tencent.mm/.ui.LauncherUI
