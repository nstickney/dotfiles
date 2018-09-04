#!/usr/bin/env bash

# BASE CONFIGURATION ##########################################################

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Check window size after each command and update $LINES and $COLUMNS as needed
[ "$DISPLAY" ] && shopt -s checkwinsize

# Recursive **/* and `cd` when only entering a path (does not work on OS X)
if [ "$(uname -s)" != "Darwin" ]; then
	shopt -s globstar
	shopt -s autocd
fi

# Fix perl complaining about LC_ALL
export LC_ALL=en_US.UTF-8

# BASH PROMPT #################################################################

bash_prompt_command() {
	# Git branch
	GTBR=$(git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/')
	# How many characters of the $PWD should be kept
	local pwdmaxlen=$((COLUMNS - 34 - ${#HOSTNAME} - ${#USER} - ${#GTBR}))
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
	local U="\\[\\e[0m\\]"     # default foreground color

	# regular colors
	local G="\\[\\e[0;32m\\]"  # green

	# emphasized (bolded) colors
	local ER="\\[\\e[1;31m\\]" # bold red
	local EY="\\[\\e[1;33m\\]" # bold yellow
	local EB="\\[\\e[1;34m\\]" # bold blue
	local EV="\\[\\e[1;35m\\]" # bold violet
	local EC="\\[\\e[1;36m\\]" # bold cyan

	local UC=$EY                # user's color
	[ $UID -eq "0" ] && UC=$ER  # root's color

   PS1="\\n    \\t \\d ${UC}\\u${U}@${EC}\\h${U}:${EB}\${CPWD}${EV}\${GTBR}${U}\\n[${G}\\s${U}] ${UC}\\$ ${U}"
}

PROMPT_COMMAND=bash_prompt_command
bash_prompt
unset bash_prompt

# COLORIZE EVERYTHING #########################################################

# the tty/framebuffer console
if [ "$TERM" = "linux" ]; then
	echo -en "\\e]P0333333" # black
	echo -en "\\e]P8666666" # gray
	echo -en "\\e]P1CC0099" # red
	echo -en "\\e]P9FF4DD2" # bright red
	echo -en "\\e]P299CC00" # green
	echo -en "\\e]PAD2FF4D" # bright green
	echo -en "\\e]P3CC4400" # brown
	echo -en "\\e]PBFF884D" # yellow
	echo -en "\\e]P40099CC" # blue
	echo -en "\\e]PC4DD2FF" # bright blue
	echo -en "\\e]P53300CC" # magenta
	echo -en "\\e]PD794DFF" # bright magenta
	echo -en "\\e]P600CC33" # cyan
	echo -en "\\e]PE4DFF79" # bright cyan
	echo -en "\\e]P7999999" # light gray
	echo -en "\\e]PFEEEEEE" # white
	clear # fix artifacts
fi

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
if grep --color "a" <<< "a" &>/dev/null; then
	alias grep='grep --color=auto'
	alias fgrep='fgrep --color=auto'
	alias egrep='egrep --color=auto'
fi

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
[ -r /usr/share/bash-completion/bash_completion ] && . /usr/share/bash-completion/bash_completion

# Find-The-Command
[ -r /usr/share/doc/find-the-command/ftc.bash ] && source /usr/share/doc/find-the-command/ftc.bash

# Sudo Completion
[ -x "$(command -v sudo)" ] && complete -cf sudo

# DEFEAT LOGGING ##############################################################

# Defeat Snoopy logging (http://blog.rchapman.org/posts/Bypassing_snoopy_logging/)
[ ! -f "$HOME"/dotfiles/bin/bypass.so ] && \
	[ -x "$(command -v gcc)" ] && \
	[ -f "$HOME"/dotfiles/bin/bypass.c ] && \
	gcc -nostartfiles -shared -O3 -fPIC "$HOME"/dotfiles/bin/bypass.c -o "$HOME"/dotfiles/bin/bypass.so -ldl -Wall -Wextra
[ -x "$HOME"/dotfiles/bin/bypass.so ] && export LD_PRELOAD=$HOME/dotfiles/bin/bypass.so

# HISTORY #####################################################################

# Avoid duplicates, and share history across terminals
export HISTCONTROL=ignoredups:erasedups
shopt -s histappend
PROMPT_COMMAND="history -n; history -w; history -c; history -r; $PROMPT_COMMAND"

# Max history size
export HISTFILESIZE=8192

# PATH ########################################################################
export PATH="$PATH":"$HOME"/dotfiles/bin
[ -d "$HOME"/dotfiles/overrides ] && export PATH="$HOME"/dotfiles/overrides:$PATH

# SPELLING ####################################################################
shopt -s cdspell
[ "$(uname -s)" != "Darwin" ] && shopt -s dirspell

# GPG KEY #####################################################################
GPG_TTY="$(tty)"
export GPG_TTY

# USER ALIASES ################################################################

# Import SSH aliases from protected file
# shellcheck source=/dev/null
[ -f "$HOME"/SafeDepositBox/"$USER"/ssh-aliases.sh ] && source "$HOME"/SafeDepositBox/"$USER"/ssh-aliases.sh

# cd
alias cd..='cd ..'

# editor
if [ -x "$(command -v vim)" ]; then
	alias vi='vim'
	export EDITOR='vim'
fi

# git
alias commit='git commit -m'
alias pull='git pull origin master'
alias push='git push origin master'

# ls
[ ! -x "$(command -v ll)" ] && alias ll='ls -la'

# less is more
alias more='less'

# ping
alias pinc='ping -c5'

# sudo
if [ -x "$(command -v sudo)" ]; then

	# Editor
	[ -x "$(command -v vim)" ] && alias svi="sudo vim"

	# Networking

	### firewall-cmd
	[ -x "$(command -v firewall-cmd)" ] && alias fw='sudo firewall-cmd'

	### SS / Netstat
	if [ -x "$(command -v ss)" ]; then
		alias ss='sudo ss'
	elif [ -x "$(command -v netstat)" ]; then
		alias netstat='sudo netstat'
	fi
	[ "$(type -t ss)" == "alias" ] && alias sl='ss -ltunp'

	# Package Managers

	### Apt (Apt-Metalink)
	if [ -x "$(command -v apt)" ]; then
		if [ -x "$(command -v apt-metalink)" ]; then
		    alias apt='sudo apt-metalink'
		else
			alias apt='sudo apt'
		fi
		alias aptup='apt update && apt upgrade && apt dist-upgrade'
	fi

	### DNF/Yum
	if [ -x "$(command -v dnf)" ]; then
		alias dnf='sudo dnf'
	elif [ -x "$(command -v yum)" ]; then
		alias dnf='sudo yum'
	fi
	alias dnfup='dnf -y update'

	### Pacman (Reflector/Powerpill/Aurman)
	if [ -x "$(command -v pacman)" ]; then

		# Reflector
		[ -x "$(command -v reflector)" ] && alias reflect='sudo printf "Updating Mirrorlist..." && sudo reflector -l 50 -a 12 -p https --sort rate --save /etc/pacman.d/mirrorlist'

		# Powerpill or Pacman
		if [ -x "$(command -v powerpill)" ]; then
			PACMAN="$(command -v powerpill)"
			alias pac='sudo powerpill'
		else
			PACMAN="$(command -v pacman)"
			alias pac='sudo pacman'
		fi
		export PACMAN
		alias pacup='yes | pac -Syyu --noconfirm'

		# Aurman
		if [ -x "$(command -v aurman)" ]; then
			alias pac='aurman --sort_by_name'
			alias pacup='yes | pac -Syyu --noedit --noconfirm --devel'
		fi

		# Combos
		if [ "$(type reflect 2>/dev/null)" ]; then
			alias rpac='reflect && pac'
			alias rpacup='reflect && pacup'
		fi
	fi

	# System
	[ -x "$(command -v su)" ] && alias su='sudo su'
	[ -x "$(command -v systemctl)" ] && alias sctl='sudo systemctl'
fi

# TABS ########################################################################
[ -x "$(command -v tabs)" ] && tabs 4
