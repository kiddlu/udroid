#!/bin/bash

#set -x

for pid in `ps -aux | sed '1d' | awk '{print $2}'`; do
  calc=`cat /proc/$pid/cmdline | wc -c`
  if [ $calc -eq "0" ]; then
    echo -e "$pid\t`ionice -p $pid`\t[`cat /proc/$pid/task/$pid/comm`]"
  else
    echo -e "$pid\t`ionice -p $pid`\t`cat /proc/$pid/cmdline`"
  fi
done
