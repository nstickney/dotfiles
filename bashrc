#!/bin/bash

# DEFAULT STUFF ###############################################################

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Check window size after each command and update $LINES and $COLUMNS as needed
[[ $DISPLAY ]] && shopt -s checkwinsize

# Get useful error information
#set -x

# Recursive **/* and `cd` when only entering a path
if [ "$(uname -s)" != "Darwin" ]; then
    shopt -s globstar
    shopt -s autocd
fi

# DEFEAT LOGGING ##############################################################

# Defeat Snoopy logging (http://blog.rchapman.org/posts/Bypassing_snoopy_logging/)
[ ! -f "$HOME"/dotfiles/bin/bypass.so ] && \
    [ -x "$(command -v gcc)" ] && \
    [ -f "$HOME"/dotfiles/bin/bypass.c ] && \
    gcc -nostartfiles -shared -O3 -fPIC "$HOME"/dotfiles/bin/bypass.c -o "$HOME"/dotfiles/bin/bypass.so -ldl -Wall -Wextra
[ -x "$HOME"/dotfiles/bin/bypass.so ] && export LD_PRELOAD=$HOME/dotfiles/bin/bypass.so

# BASH PROMPT #################################################################

bash_prompt_command() {
    # How many characters of the $PWD should be kept
    local pwdmaxlen=25
    # Indicate that there has been dir truncation
    local trunc_symbol="..."
    local dir=${PWD##*/}
    pwdmaxlen=$(( ( pwdmaxlen < ${#dir} ) ? ${#dir} : pwdmaxlen ))
    CPWD=${PWD/#$HOME/\~}
    local pwdoffset=$(( ${#CPWD} - pwdmaxlen ))
    if [ ${pwdoffset} -gt "0" ]
    then
        CPWD=${CPWD:$pwdoffset:$pwdmaxlen}
        CPWD=${trunc_symbol}/${CPWD#*/}
    fi
}

bash_prompt() {
    local U="\\[\\e[0m\\]"     # unsets color to term's fg color

    # regular colors
    local G="\\[\\e[0;32m\\]"  # green

    # emphasized (bolded) colors
    local ER="\\[\\e[1;31m\\]" # bold red
    local EY="\\[\\e[1;33m\\]" # bold yellow
    local EB="\\[\\e[1;34m\\]" # bold blue
    local EC="\\[\\e[1;36m\\]" # bold cyan

    local UC=$EY                # user's color
    [ $UID -eq "0" ] && UC=$ER  # root's color

    PS1="\\n  \\t \\d\\n${UC}\\u${U}@${EC}\\h${U}[${G}\\s${U}]:${EB}\${CPWD}${UC} \\$ ${U}"
}

PROMPT_COMMAND=bash_prompt_command
bash_prompt
unset bash_prompt

# COLORIZE EVERYTHING #########################################################

# ls
if [ "$(uname -s)" == "Darwin" ]; then
    alias ls='ls -G'
else
    alias ls='ls --color=auto'
fi
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'
[ -x "$(command -v dircolors)" ] && eval "$(dircolors -b)"

# grep
export GREP_COLOR="1;33"
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# diff
[ -x "$(command -v colordiff)" ] && alias diff='colordiff'

# less
[ -e /usr/bin/source-higthlight-esc.sh ] && export LESSOPEN="| /usr/bin/source-highlight-esc.sh %s"
export LESS='-R'

# man - colored, and with help
man() {
    env \
        LESS_TERMCAP_mb="$(printf '\e[1;32m')" \
        LESS_TERMCAP_md="$(printf '\e[1;33m')" \
        LESS_TERMCAP_me="$(printf '\e[0m')" \
        LESS_TERMCAP_se="$(printf '\e[0m')" \
        LESS_TERMCAP_so="$(printf '\e[1;45;30m')" \
        LESS_TERMCAP_ue="$(printf '\e[0m')" \
        LESS_TERMCAP_us="$(printf '\e[0;34m')" \
        man "$@" || (help "$@" 2> /dev/null && help "$@" | less)
}

# COMPLETION ##################################################################

# Bash completion where available
# shellcheck source=/dev/null
[ -r /usr/share/bash-completion/bash_completion ] && . /usr/share/bash-completion/bash_completion

# Find-The-Command
# shellcheck source=/dev/null
[ -r /usr/share/doc/find-the-command/ftc.bash ] && source /usr/share/doc/find-the-command/ftc.bash

# Sudo Completion
[ -x "$(command -v sudo)" ] && complete -cf sudo

# HISTORY #####################################################################

# Avoid duplicates, and share history across terminals
export HISTCONTROL=ignoredups:erasedups
shopt -s histappend
PROMPT_COMMAND="history -n; history -w; history -c; history -r; $PROMPT_COMMAND"

# Max history size
export HISTFILESIZE=8192

# SPELLING ####################################################################

shopt -s cdspell
[ "$(uname -s)" != "Darwin" ] && shopt -s dirspell

# ALIASES #####################################################################

# Import SSH aliases from protected file
# shellcheck source=/dev/null
[ -f "$HOME"/SafeDepositBox/"$USER"/ssh-aliases.sh ] && source "$HOME"/SafeDepositBox/"$USER"/ssh-aliases.sh

# Arch-specific aliasing
if grep -q Arch < /etc/os-release; then
    # Reflector
    [ -x "$(command -v reflector)" ] && alias reflect='sudo echo "Updating Mirrorlist..." && sudo reflector -l 50 -a 12 -p https --sort rate --save /etc/pacman.d/mirrorlist'

    # Pacaur
    if [ -x "$(command -v pacaur)" ]; then
        alias pac='pacaur'
        [ "$(type reflect 2>/dev/null)" ] && alias rpac='reflect && yes | pac -Syyu --noedit --noconfirm'

    # Pacman
    else
        alias pac='pacman'
        [ "$(type reflect 2>/dev/null)" ] && alias rpac='reflect && yes | sudo pac -Syyu --noc onfirm'
    fi
fi

# cd
alias cd..='cd ..'

# firewall-cmd
[ -x "$(command -v firewall-cmd)" ] && alias fw='sudo firewall-cmd'

# git
alias commit='git commit -m'
alias pull='git pull origin master'
alias push='git push origin master'

# ls
[ ! -x "$(command -v ll)" ] && alias ll='ls -la'

# more is less
alias more='less'

# ping
alias pinc='ping -c5'

# ss (replaces netstat)
if [ -x "$(command -v ss)" ]; then
    [ -x "$(command -v sudo)" ] && alias sl='sudo ss -ltunp' || sl='ss -ltunp'
elif [ -x "$(command -v netstat)" ]; then
    [ -x "$(command -v sudo)" ] && alias sl='sudo netstat -ltunp' || sl='netstat -ltunp'
fi

# sudo / su / root
[ -x "$(command -v sudo)" ] && alias su='sudo su'

# systemctl
[ -x "$(command -v systemctl)" ] && alias sctl='sudo systemctl'

# vim
if [ -x "$(command -v vim)" ]; then
    alias vi='vim'
    alias svi='sudo vim'
    alias svim='sudo vim'
    export EDITOR='vim'
else
    alias svi='sudo vi'
    export EDITOR='vi'
fi
