# User dependent .bashrc file

# If not running interactively, don't do anything
[[ "$-" != *i* ]] && return

export TERM=xterm-256color
export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games
export PATH=$PATH:/sbin:/vendor/bin:/system/sbin:/system/bin:/system/xbin
export PATH=/data/ubuntu/usr/local/android/bin:$PATH

export ANDROID_DATA=/data

if [[ `/usr/bin/stat -c %i /` -ne "2" ]]; then
  PS1='\n\[\033[01;32m\]chroot\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\n# '
  export OS_PLATFORM=chroot
else
  PS1='\n\[\033[45;30m\]skeleton\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\n# '
  export OS_PLATFORM=skeleton
fi

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
