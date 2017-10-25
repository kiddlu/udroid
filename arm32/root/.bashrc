# User dependent .bashrc file

# If not running interactively, don't do anything
[[ "$-" != *i* ]] && return

PS1='\n\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\n# '

export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games

source ~/.udroidrc
