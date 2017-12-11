# User dependent .bashrc file
export ANDROID_DATA=/data

export TERM=xterm-256color
export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games
export PATH=$PATH:/sbin:/vendor/bin:/system/sbin:/system/bin:/system/xbin
export PATH=/usr/local/android/bin:/usr/local/wrapper:$PATH

if [[ `/usr/bin/stat -c %i /` -ne "2" ]]; then
  PS1='\n\[\033[01;32m\]chroot@android\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\n# '
  export OS_PLATFORM=chroot
else
  PS1='\n\[\033[01;32m\]skeleton@android\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\n# '
  export OS_PLATFORM=skeleton
fi

# If not running interactively, return 
[[ "$-" != *i* ]] && return

function ld-preload-switch()
{
  if [ "$LD_PRELOAD" ]; then
    export LD_PRELOAD_OLD=$LD_PRELOAD
    unset LD_PRELOAD
  else
    if [ "$LD_PRELOAD_OLD" ]; then
      export LD_PRELOAD=$LD_PRELOAD_OLD
      unset LD_PRELOAD_OLD
    fi
  fi
}


function ld-hook()
{
    export LD_PRELOAD=$LD_PRELOAD:/usr/local/android/hook/libandroid-shmem.so
}
