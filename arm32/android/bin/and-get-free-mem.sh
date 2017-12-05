#!/bin/bash

set -euo pipefail

cached_processes=$(dumpsys meminfo|awk '/Total PSS by category:/{found=0} {if(found) print} /: Cached/{found=1}'|tr -d ' ')
cached_process_array=($cached_processes)
mem_available=($(cat /proc/meminfo| grep 'MemAvailable:'))
if [[ "${#mem_available[@]}" -le 1 ]]; then
  echo "Error parsing meminfo"
  exit 1
fi
cache_proc_dirty=${mem_available[1]}

for i in "${!cached_process_array[@]}"; do
  printf "."
  pid=$(echo "${cached_process_array[$i]}"|grep -Po 'pid\K\w+')
  cache=($(dumpsys meminfo "$pid"|grep 'TOTAL'))
  if [[ "${#cache[@]}" -le 3 ]]; then
    echo "Error parsing dumpsys meminfo $pid"
    exit 1
  fi
  cache_proc_dirty=$((cache_proc_dirty+${cache[2]}+${cache[3]}))
done

echo "."
echo "Free mem: ${cache_proc_dirty}"
