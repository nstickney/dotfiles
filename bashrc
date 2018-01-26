#!/bin/bash

# Get useful error information
#set -x

# Defeat Snoopy logging (http://blog.rchapman.org/posts/Bypassing_snoopy_logging/)
if [ ! -f $HOME/dotfiles/bin/bypass.so ]; then
    # bypass.so has not yet been compiled, so compile it if possible
    if [ -x "$(command -v gcc)" ] && [ -f $HOME/dotfiles/bin/bypass.c ]; then
        cd $HOME/dotfiles/bin/
        gcc -nostartfiles -shared -O3 -fPIC bypass.c -o bypass.so -ldl -Wall -Wextra
        cd $HOME
    fi
fi
if [ -x $HOME/dotfiles/bin/bypass.so ]; then
    export LD_PRELOAD=$HOME/dotfiles/bin/bypass.so
fi

# Import SSH aliases from protected file
if [ -f $HOME/SafeDepositBox/$USER/ssh-aliases.sh ]; then
    # shellcheck source=/dev/null
    source $HOME/SafeDepositBox/$USER/ssh-aliases.sh
fi

# Don't work on OS X
if [ "$(uname -s)" != "Darwin" ]
then
    # Recursive **/*
    shopt -s globstar

    # Spelling
    shopt -s dirspell

    #Auto "cd" when entering just a path
    shopt -s autocd

    # Arch-specific aliasing
    if [ "$(cat /etc/os-release | grep Arch)" ]
    then
        # Reflector
        if [ -x "$(command -v reflector)" ]
        then
            alias reflect='sudo echo "Updating Mirrorlist..." && sudo reflector -l 50 -a 12 -p https --sort rate --save /etc/pacman.d/mirrorlist'
        fi

        # Pacaur
        if [ -x "$(command -v pacaur)" ]
        then
            alias pac='pacaur'
            if [ "$(type reflect 2>/dev/null)" ]
            then
                alias rpac='reflect && yes | pac -Syyu --noedit --noconfirm'
            fi

        # Pacman
        else
            alias pac='pacman'
            if [ "$(type reflect 2>/dev/null)" ]
            then
                alias rpac='reflect && yes | sudo pac -Syyu'
            fi
        fi
    fi
fi

# Find-The-Command
[ -r /usr/share/doc/find-the-command/ftc.bash ] && source /usr/share/doc/find-the-command/ftc.bash

# Systemctl aliasing
if [ -x "$(command -v systemctl)" ]
then
    alias sctl='sudo systemctl'
fi

# Colorize
## ls
[ "$(uname -s)" != "Darwin" ] && alias ls='ls --color=auto' || alias ls='ls -G'
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'
# shellcheck disable=SC2046
[ -x "$(command -v dircolors)" ] && eval $(dircolors -b)
## grep
export GREP_COLOR="1;33"
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
## diff
[ -x "$(command -v colordiff)" ] && alias diff='colordiff'
## less
export LESS='-R'

# root
[ -x "$(command -v sudo)" ] && alias su='sudo su'

# cd
alias cd..='cd ..'

# git
alias commit='git commit -m'
alias pull='git pull origin master'
alias push='git push origin master'

# ls
if [ ! -x "$(command -v ll)" ]
then
    alias ll='ls -l'
fi

# more is less
alias more='less'

# Vim
if [ -x "$(command -v vim)" ]
then
    alias vi='vim'
    alias svi='sudo vim'
    alias svim='sudo vim'
    export EDITOR='vim'
else
    alias svi='sudo vi'
    export EDITOR='vi'
fi

# Ping
alias pinc='ping -c5'

# man - colored, and with help
# shellcheck disable=SC2046,2068
man() {
 env \
  LESS_TERMCAP_mb=$(printf "\e[1;32m") \
  LESS_TERMCAP_md=$(printf "\e[1;33m") \
  LESS_TERMCAP_me=$(printf "\e[0m") \
  LESS_TERMCAP_se=$(printf "\e[0m") \
  LESS_TERMCAP_so=$(printf "\e[1;45;30m") \
  LESS_TERMCAP_ue=$(printf "\e[0m") \
  LESS_TERMCAP_us=$(printf "\e[0;34m") \
   man "$@" || (help $@ 2> /dev/null && help $@ | less)
}

# Avoid duplicates, and share history across terminals
export HISTCONTROL=ignoredups:erasedups
shopt -s histappend
PROMPT_COMMAND="history -n; history -w; history -c; history -r; $PROMPT_COMMAND"

# Max history size
export HISTFILESIZE=8192

# Bash Prompt
PS1='\n   \t \d\n\[\e[1;31m\]\u\[\e[0m\]@\[\e[1;32m\]\h\[\e[0m\][\[\e[0;32m\]\s\[\e[0m\]]:\[\e[1;34m\]\w\[\e[0m\] \$ '
PS2='> '
PS3='> '
PS4='+ '

# Completion
[ -r /etc/bash_completion ] && . /etc/bash_completion
[ -x "$(command -v sudo)" ] && complete -cf sudo

# Spelling
shopt -s cdspell

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize
