#!/bin/bash

#set -x

for pid in `ps -aux | awk '{print $2}'`; do
  calc=`cat /proc/$pid/cmdline | wc -c`
  if [ $calc -eq "0" ]; then
    echo "$pid `ionice -p $pid` [`cat /proc/$pid/task/$pid/comm`]"
  else
    echo "$pid `ionice -p $pid` `cat /proc/$pid/cmdline`"
  fi
done