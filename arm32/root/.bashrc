# User dependent .bashrc file
#export ANDROID_DATA=/data
#export ANDROID_ROOT=/system

export TERM=xterm-256color
export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games
export PATH=/usr/local/udroid/adb:/usr/local/udroid/bin:/usr/local/udroid/python:/usr/local/udroid/shell:/usr/local/udroid/wrapper:$PATH

if [[ `/usr/bin/stat -c %i /` -ne "2" ]]; then
  PS1='\n\[\033[01;32m\]chroot@android\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\n# '
  #export OS_PLATFORM=chroot
else
  PS1='\n\[\033[01;32m\]skeleton@android\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\n# '
  #export OS_PLATFORM=skeleton
fi

# If not running interactively, return 
[[ "$-" != *i* ]] && return


######
# alias
######
# Interactive operation...
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

# Default to human readable figures
alias df='df -h'
alias du='du -h'

# Misc :)
alias less='less -r'                          # raw control characters
alias whence='type -a'                        # where, of a sort
alias grep='grep --color'                     # show differences in colour
alias egrep='egrep --color=auto'              # show differences in colour
alias fgrep='fgrep --color=auto'              # show differences in colour

# Some shortcuts for different directory listings
alias ls='ls -hF --color=tty --show-control-chars'                 # classify files in colour
alias dir='ls --color=auto --format=vertical --show-control-chars'
alias vdir='ls --color=auto --format=long --show-control-chars'
alias ll='ls -l --show-control-chars'                              # long list
alias la='ls -A --show-control-chars'                              # all but . and ..
alias l='ls -CF --show-control-chars'                              #

######
# function
######
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
