#!/bin/bash
set -x
cpus=0
cpus=`cat /proc/cpuinfo | grep processor | wc -l`
cpus=$((cpus - 1))

for nb in `seq 0 $cpus`; do
  echo performance > /sys/devices/system/cpu/cpu$nb/cpufreq/scaling_governor
  max_freq=`cat /sys/devices/system/cpu/cpu$nb/cpufreq/cpuinfo_max_freq`
  echo $max_freq > /sys/devices/system/cpu/cpu$nb/cpufreq/scaling_min_freq
  echo $max_freq > /sys/devices/system/cpu/cpu$nb/cpufreq/scaling_max_freq
done
