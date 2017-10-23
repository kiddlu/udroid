#!/bin/bash

set -x

function capture_func()
{
    #/proc
    for index in bootprof buddyinfo cgroups cmdline config.gz cpuinfo devices diskstats \
                 filesystems interrupts iomem ioports kallsyms last_kmsg latency_stats loadavg \
    			 lockdep lockdep_chains lockdep_stats locks meminfo misc mounts \
    			 pagetypeinfo partitions schedstat softirqs stat swaps tasks_all tasks_rq \
    			 timer_list uptime version vmallocinfo vmstat zoneinfo zraminfo; do
        cat /proc/$index > proc_$index &
    done
    
    
    #sys
    cat /sys/kernel/debug/blockio > sys_blockio
    cat /sys/kernel/debug/tracing/trace > sys_ftrace
    cat /sys/kernel/debug/wakeup_sources > sys_wakeup_sources
    cat /sys/kernel/debug/shrinker > sys_shrinker
    
    #tools
    dmesg > tools_dmesg
    ifconfig > tools_ifconfig
    ps -aux > tools_ps-aux
    pidstat -l > tools_pidstat-l
    iostat > tools_iostat
    lsof > tools_lsof
    top -bc -n1 > tools_top-bcn1
    vmstat -d > tools_vmstat-d
    vmstat -D > tools_vmstat-D
    vmstat -w > tools_vmstat-w
    df -h > tools_df-h
    
    #android
	if [[ "$OS_PLATFORM" = "android" ]]; then
        /system/bin/getprop > android_getprop
        /system/bin/procrank > android_procrank
        /system/bin/lsof > android_lsof
        /system/bin/dumpsys > android_dumpsys
        /system/bin/ps -P -p -c > android_ps-Ppc
        /system/bin/logcat -d > android_logcat-d
        cat /proc/sched_debug > android_sched_debug
	fi
}

capture_func 2>&1 | tee capture_log