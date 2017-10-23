# User dependent .bashrc file

# If not running interactively, don't do anything
[[ "$-" != *i* ]] && return

export OS_PLATFORM=android
export PATH=/bin:/usr/bin:/sbin:/usr/sbin:/usr/local/bin:/usr/local/sbin:$PATH
export TERM=xterm
export LD_PRELOAD_OLD=$LD_PRELOAD
unset LD_PRELOAD

echo 0 > /proc/sys/kernel/kptr_restrict

cat <<EOF
make sure that your kernel enable these configs

/proc/kmsg :
#CONFIG_BOOT_PRINTK_DELAY=y
CONFIG_LOG_BUF_SHIFT=21

/proc/config.gz :
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y

/proc/kallsyms :
CONFIG_KALLSYMS=y
CONFIG_KALLSYMS_ALL=y

/proc/sys && sysctl :
CONFIG_SYSCTL_SYSCALL=y

/proc/<pid>/io :
CONFIG_TASK_DELAY_ACCT=y
CONFIG_TASKSTATS=y
CONFIG_TASK_IO_ACCOUNTING=y

/sys/kernel/debug/tracing/block/ :
CONFIG_BLK_DEV_IO_TRACE=y

PROBE_EVENTS :
Kconfig def_bool n > y
CONFIG_PROBE_EVENTS=y

/sys/kernel/debug/tracing/kprobe_events :
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
CONFIG_KPROBES=y
CONFIG_KPROBE_EVENT=y

/sys/kernel/debug/tracing/uprobe_events :
CONFIG_UPROBES=y
CONFIG_UPROBE_EVENT=y

ftrace :
CONFIG_FTRACE=y
CONFIG_FUNCTION_TRACER=y
CONFIG_FUNCTION_GRAPH_TRACER=y

/sys/kernel/debug/tracing/available_filter_functions(set_ftrace_filter, set_ftrace_notrace) :
CONFIG_DYNAMIC_FTRACE=y

/sys/kernel/debug/tracing/function_profile_enabled :
CONFIG_FUNCTION_PROFILER=y

/sys/kernel/debug/tracing/events/syscalls :
CONFIG_FTRACE_SYSCALLS=y

tracer :
CONFIG_IRQSOFF_TRACER
CONFIG_PREEMPT_TRACER
CONFIG_SCHED_TRACER
CONFIG_STACK_TRACER

hung :
CONFIG_DETECT_HUNG_TASK=y
CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=120
# CONFIG_BOOTPARAM_HUNG_TASK_PANIC is not set
CONFIG_BOOTPARAM_HUNG_TASK_PANIC_VALUE=0

lock :
CONFIG_DEBUG_SPINLOCK=y
CONFIG_DEBUG_MUTEXES=y
CONFIG_DEBUG_LOCK_ALLOC=y
CONFIG_PROVE_LOCKING=y
CONFIG_LOCKDEP=y
CONFIG_DEBUG_LOCKDEP=y
CONFIG_DEBUG_ATOMIC_SLEEP=y
CONFIG_TRACE_IRQFLAGS=y
CONFIG_STACKTRACE=y

EOF

PS1='\n\[\033[01;32m\]ubuntu-on-android\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\n# '
