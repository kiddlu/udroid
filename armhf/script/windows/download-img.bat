@echo on

set UBUNTU_ROOTFS=.\ubuntu.tar.gz
set UBUNTU_CLOUDIMG=https://uec-images.ubuntu.com/xenial/current/xenial-server-cloudimg-armhf-root.tar.gz

"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" ^
-NoProfile -InputFormat None -ExecutionPolicy Bypass ^
-Command "((New-Object System.Net.WebClient).DownloadFile('%UBUNTU_CLOUDIMG%','%UBUNTU_ROOTFS%'))"
