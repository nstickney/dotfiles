#!/usr/bin/env bash

# BASE CONFIGURATION ##########################################################

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Used to source various files
source_if_readable() {
	# shellcheck disable=1090
	[ -f "$1" ] && [ -r "$1" ] && source "$1"
}

# Vi mode
set -o vi
bind -m vi-insert "\C-l":clear-screen

# Check window size after each command and update $LINES and $COLUMNS as needed
[ "$DISPLAY" ] && shopt -s checkwinsize

# Recursive **/* and `cd` when only entering a path (does not work on OS X)
if [ "$(uname -s)" != "Darwin" ]; then
	shopt -s globstar
	shopt -s autocd
fi

# Fix perl complaining about LC_ALL
export LC_ALL=en_US.UTF-8

# Fix spelling
shopt -s cdspell
[ "$(uname -s)" != 'Darwin' ] && shopt -s dirspell

# Fix gpg agent
GPG_TTY="$(tty)"
export GPG_TTY

# Fix ssh agent
if [ -x "$(command -v ssh-agent)" ]; then
	eval "$(ssh-agent -t 240)" >/dev/null
	trap '[ -n "$SSH_AGENT_PID" ] && eval $(ssh-agent -k); exit' EXIT
fi

# Tabs default to four spaces wide
[ -x "$(command -v tabs)" ] && tabs 4

# BASH PROMPT #################################################################

__prompt_command() {

	# Start with exit status of previous command, and date
	PS1="\\n    \\D{%a %Y.%m.%d %T} [\\j][\${PIPESTATUS[@]}]\\n"

	# How many characters of the $PWD should be kept
	local pwdmaxlen=$((COLUMNS - 32 - ${#HOSTNAME} - ${#USER}))
	local dir=${PWD##*/}
	pwdmaxlen=$(( ( pwdmaxlen < ${#dir} ) ? ${#dir} : pwdmaxlen ))
	CPWD=${PWD/#$HOME/\~}
	local pwdoffset=$(( ${#CPWD} - pwdmaxlen ))
	if [ ${pwdoffset} -gt "0" ]; then
		CPWD=${CPWD:$pwdoffset:$pwdmaxlen}
		CPWD='.../'"${CPWD#*/}"
	fi

	# Colors
	local U="\\[\\e[0m\\]"     # default foreground color

	## regular colors
	local R="\\[\\e[0;31m\\]"  # red
	local G="\\[\\e[0;32m\\]"  # green
	local B="\\[\\e[0;34m\\]"  # blue
	local C="\\[\\e[0;36m\\]"  # cyan

	## emphasized (bolded) colors
	local ER="\\[\\e[1;31m\\]" # bold red

	local UC=$R                # user's color

	[ "$(id -u)" -eq '0' ] && UC=$ER                 # root's color

	# Next line shows username, hostname, current working directory, git status
	PS1+="  ${UC}\\u${U}@${C}\\h${U}:${B}\${CPWD}${U}\\n"

	# Last line shows bash version and prompt level (root vs nonroot)
	PS1+="[${G}\\s \\V${U}] ${UC}\\$ ${U}"
}

PROMPT_COMMAND=__prompt_command

# COLORIZE EVERYTHING #########################################################

# the tty/framebuffer console
if [ "$TERM" = 'linux' ]; then
	printf "\\e]P01A1A1A" # black
	printf "\\e]P1C22436" # red     (red)
	printf "\\e]P2A58440" # green   (yellow)
	printf "\\e]P3E64D00" # brown   (orange)
	printf "\\e]P40077E6" # blue    (blue)
	printf "\\e]P5AB3B85" # magenta (purple)
	printf "\\e]P635B181" # cyan    (green)
	printf "\\e]P7E6E6E6" # light gray
	printf "\\e]P8333333" # gray
	printf "\\e]P9DF5363" # bright red
	printf "\\e]PAC6A86C" # bright green
	printf "\\e]PBFF7733" # yellow
	printf "\\e]PC338CFF" # bright blue
	printf "\\e]PDCB67AA" # bright magenta
	printf "\\e]PE62D0A6" # bright cyan
	printf "\\e]PFFFF8E7" # white
	clear # fix artifacts
fi

# ls
if [ "$(uname -s)" == 'Darwin' ]; then
	# shellcheck disable=2032
	alias ls='ls -G'
else
	alias ls='ls --color=auto'
fi
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'
[ -n "$(command -v dircolors)" ] && eval "$(dircolors -b)"

# grep
export GREP_COLOR='1;33'
if grep --color 'a' <<< 'a' &>/dev/null; then
	alias grep='grep --color=auto'
	alias fgrep='fgrep --color=auto'
	alias egrep='egrep --color=auto'
fi

# diff
[ -x "$(command -v colordiff)" ] && alias diff='colordiff'

# less
if [ -x /usr/bin/source-highlight-esc.sh ]; then
	export LESSOPEN="| /usr/bin/source-highlight-esc.sh %s"
	export LESS='-R'
fi

# make
[ -x "$(command -v colormake)" ] && alias make='colormake'

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

# ping
[ -x "$(command -v prettyping)" ] && alias ping='prettyping'

# COMPLETION ##################################################################

# Bash completion where available
source_if_readable /usr/share/bash-completion/bash_completion

# Fuzzy Finder
source_if_readable /usr/share/fzf/completion.bash
source_if_readable /usr/share/fzf/key-bindings.bash

# Git
source_if_readable /usr/share/git/completion/git-completion.bash

# History search
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'
bind '"\e[5~": previous-history'
bind '"\e[6~": next-history'

# Sudo Completion
[ -n "$(command -v sudo)" ] && complete -cf sudo

# HISTORY #####################################################################

# Colon seperated list of exact commands to ignore
export HISTIGNORE="clear:bg:fg:cd:cd -:exit:date:poweroff:reboot:* --help"

# Avoid duplicates, and share history across terminals
export HISTCONTROL=ignoredups:erasedups
shopt -s histappend
PROMPT_COMMAND="history -n;history -w;history -c;history -r;$PROMPT_COMMAND"

# Max history size
export HISTFILESIZE=8192

# PATH ########################################################################

# Remove duplicate items from path
# https://unix.stackexchange.com/a/338737
remove_dups() {
	local D=${2:-:}
	local path=
	local dir=
	while IFS= read -r -d"$D" dir; do
		[[ $path$D =~ .*$D$dir$D.* ]] || path+="$D$dir"
	done <<< "$1$D"
	printf %s "${path#$D}"
}
PATH="$(remove_dups "$PATH")"

# Cleanly add an item to the end of $PATH
# https://unix.stackexchange.com/a/124447
path_append() {
	case ":${PATH:=$1}:" in
		*:$@:*) ;;
		*) PATH="$PATH:$1";;
	esac
}

# Cleanly add an item to the beginning of $PATH
path_override() {
	case ":${PATH:=$1}:" in
		*:$@:*) ;;
		*) PATH="$1:$PATH";;
	esac
}

# NVM
source_if_readable /usr/share/nvm/init-nvm.sh
