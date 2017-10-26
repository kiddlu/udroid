# User dependent .bashrc file

# If not running interactively, don't do anything
[[ "$-" != *i* ]] && return

PS1='\n\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\n# '

export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games

export PATH=$PATH:/system/bin

export TERM=xterm-256color

if [ "$LD_PRELOAD" ]; then
    export LD_PRELOAD_OLD=$LD_PRELOAD
    unset LD_PRELOAD
fi

cat /etc/lsb-release | grep ID=Ubuntu > /dev/null

if [[ $? -eq "0" ]]; then
    export OS_PLATFORM=udroid
else
    export OS_PLATFORM=android
fi
