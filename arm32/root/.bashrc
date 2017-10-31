# User dependent .bashrc file

# If not running interactively, don't do anything
[[ "$-" != *i* ]] && return

export PATH=/bin:/system/bin
cat /etc/lsb-release | grep ID=Ubuntu > /dev/null

if [[ $? -eq "0" ]]; then
  PS1='\n\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\n# '
  export OS_PLATFORM=ubuntu
  export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games
  export PATH=$PATH:/system/bin
  export TERM=xterm-256color
  if [ "$LD_PRELOAD" ]; then
    export LD_PRELOAD_OLD=$LD_PRELOAD
    unset LD_PRELOAD
  fi
else
  PS1='\n\[\033[45;30m\]android\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\n# '
  export OS_PLATFORM=android
  export PATH=/sbin:/vendor/bin:/system/sbin:/system/bin:/system/xbin
  export PATH=/data/ubuntu/usr/local/android/bin:$PATH
  export TERM=ansi
fi
